# ⚡ Super Saiyan Quick-Reference Cheatsheet

**Use this cheatsheet mid-hunt for quick pattern matching.**

## 🎯 High-Value Targets (Category A)
| **If you see...** | **Test for...** | **How to test** |
|:---|:---|:---|
| `id=` or `uuid=` in the request | **IDOR** | Swap the ID with another user's ID. Test both READ (GET) and WRITE (PUT/POST/DELETE) actions. |
| The app fetches a URL (e.g., integrations, webhooks, image imports) | **SSRF** | Provide a burp collaborator payload or internal IP (`127.0.0.1`, `169.254.169.254`). |
| HTML entities decoded client-side | **DOM XSS** | Try injecting `<svg onload=alert(1)>` encoded as HTML entities. |
| GraphQL queries | **GraphQL IDOR / Batching** | Try alias batching (e.g., `u1:user(id:1){email} u2:user(id:2){email}`). |
| A multi-step flow (e.g., checkout, password reset) | **Business Logic / TOCTOU** | Try skipping steps (e.g., jump straight to step 3). Test race conditions with Turbo Intruder. |
| File uploads (especially images) | **XXE / SSRF / XSS** | Upload an SVG containing an XXE or XSS payload. |

## 🔐 Auth & Session (Category B)
| **If you see...** | **Test for...** | **How to test** |
|:---|:---|:---|
| OAuth `redirect_uri` | **Open Redirect / ATO** | Change it to an attacker domain to steal the auth code. |
| JSON Web Tokens (JWT) | **JWT Attacks** | Change `alg` to `none`, test RS256 to HS256 confusion, or test Kid path traversal. |
| 2FA / MFA enabled | **MFA Bypass** | Try navigating directly to `/dashboard` after the first login step. Try reusing an old session. |
| Object assignments in requests (e.g. `{"name":"test"}`) | **Mass Assignment** | Add unexpected fields like `{"role":"admin", "isAdmin":true}`. |

## 🕸️ Advanced & Protocol (Category C)
| **If you see...** | **Test for...** | **How to test** |
|:---|:---|:---|
| WebSocket connections | **WS Auth Bypass / CSWSH** | Check if the WebSocket relies solely on the initial handshake for auth. Check Origin validation. |
| Unkeyed headers used by the app (like `Host` or `X-Forwarded-Host`) | **Cache Poisoning / Host Header Injection** | Inject a malicious host and see if the response is cached and served to others. |

*Remember: This is a quick reference. For detailed payloads and real-world examples, consult `SUPER_SAIYAN_MIND_TRAINING.md` and `SKILL.md`.*
