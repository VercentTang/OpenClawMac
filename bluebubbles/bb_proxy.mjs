#!/usr/bin/env node
import http from 'node:http';

const TARGET = process.env.BB_TARGET ?? 'http://127.0.0.1:1234';
const PASSWORD = process.env.BB_PASSWORD ?? '';
const LISTEN_PORT = Number(process.env.BB_PROXY_PORT ?? '1235');

function addPassword(url) {
  if (!PASSWORD) return url;
  const u = new URL(url);
  if (!u.searchParams.has('password')) u.searchParams.set('password', PASSWORD);
  return u;
}

const server = http.createServer(async (req, res) => {
  try {
    const inUrl = new URL(req.url ?? '/', 'http://proxy.local');
    const targetBase = new URL(TARGET);
    const outUrl = new URL(inUrl.pathname + inUrl.search, targetBase);
    const finalUrl = addPassword(outUrl);

    const headers = { ...req.headers };
    // BlueBubbles doesn't accept password in headers (some builds), so we rely on query.
    delete headers['content-length'];
    delete headers['host'];

    const isBody = !['GET','HEAD'].includes(req.method ?? 'GET');
    const upstream = await fetch(finalUrl, {
      method: req.method,
      headers,
      body: isBody ? req : undefined,
      // Node fetch requires duplex when streaming a request body.
      duplex: isBody ? 'half' : undefined,
      redirect: 'manual',
    });

    res.statusCode = upstream.status;
    upstream.headers.forEach((v, k) => {
      // avoid hop-by-hop headers
      if (k.toLowerCase() === 'transfer-encoding') return;
      res.setHeader(k, v);
    });

    const buf = Buffer.from(await upstream.arrayBuffer());
    res.end(buf);
  } catch (e) {
    res.statusCode = 502;
    res.setHeader('content-type', 'application/json');
    res.end(JSON.stringify({ error: 'bb_proxy_failed', detail: String(e) }));
  }
});

server.listen(LISTEN_PORT, '127.0.0.1', () => {
  console.log(`[bb-proxy] listening on http://127.0.0.1:${LISTEN_PORT} -> ${TARGET}`);
});
