# Deploy and Host Rybbit on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/rybbit-v2?referralCode=sLjDXb&utm_medium=integration&utm_source=button&utm_campaign=rybbit-v2)

[Rybbit](https://rybbit.com) is open-source, cookieless web and product analytics: a one-line script gives you live visitors, pages, referrers, countries down to the city, devices, UTM campaigns, goals, funnels, user journeys, retention, web vitals, error tracking and session replay, without a cookie banner. It is a modern Google Analytics or Plausible alternative, and this template runs the full self-hosted stack on Railway with no open signup page.

## About Hosting Rybbit

Six services, as in Rybbit's own docker-compose:

- **Rybbit**: the public entry point. Rybbit's Caddy routing (the API to the backend, everything else to the dashboard) on your Railway domain, with Railway's TLS.
- **Backend** and **Client**: Rybbit's official images, pinned to a release.
- **ClickHouse** for the events, **Postgres** for accounts and sites, **Redis** for live sessions. All three are private, with generated passwords and their own volumes.

What the template adds:

- **No open signup.** Rybbit gives an admin account to whoever signs up first. Here the admin account is created on first boot with a generated password, and public signup is turned off, so a fresh deployment can't be claimed by a stranger.
- **Real visitor locations.** The visitor's address is taken from the header Railway's edge sets, so countries and cities are the visitors', not Railway's.
- **ClickHouse sized for a service, not a server.** Query threads and caches are capped instead of being sized from the 48 cores Railway's hosts report, and the system log tables Rybbit never reads are off.

## Common Use Cases

- Privacy-friendly analytics for websites and web apps, without a cookie banner
- Replacing Google Analytics, Plausible or Fathom with an instance you own
- Product analytics: funnels, goals, user journeys, retention and session replay

## Dependencies for Rybbit Hosting

- ClickHouse 26.3, Postgres 17 and Redis 8 (all included, private network only)

### Deployment Dependencies

- [Rybbit documentation](https://rybbit.com/docs)
- [Template source on GitHub](https://github.com/two-workspaces/rybbit)

### Implementation Details

**Sign in** at the Rybbit service's domain with the `RYBBIT_ADMIN_EMAIL` and `RYBBIT_ADMIN_PASSWORD` values from its Variables tab, then create your organization and add a site. Change the password afterwards in your account settings; the variables are only read on first boot.

**Tracking.** Add the snippet Rybbit shows for your site to its `<head>`. The script and the events go to your Rybbit domain.

**Teammates.** Add them under Settings → Organization → Create user. Email invitations make the invitee sign up, which this template turns off; to use them, set `RYBBIT_PUBLIC_SIGNUP` to `true` on the Rybbit service (anyone with the address can then create an account).

**Memory.** About 0.9 GB across the six services at rest: ClickHouse 0.4 GB, the backend 0.3 GB, the rest under 0.1 GB each. ClickHouse grows with traffic and query load.

**Custom domain.** Add it to the Rybbit service in Settings → Networking, then set `BASE_URL` on the Backend service to `https://your.domain`.

**Upgrades.** Change the Backend and Client images to the new release tag (Settings → Source); the backend migrates its databases on start.

## Why Deploy Rybbit on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Rybbit on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
