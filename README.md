# Tree Services

Service scripts for managing an instance of [The File Tree] (https://thefiletree.com).

## Description

- `redirect`: This service redirects HTTP requests to HTTPS.
- `tree`: This service runs a secure `tree` server.
- `warden`: This script watches the `tree` service, and restarts it when needed.

## Installation

- Create a user called `dom`.
- Clone [tree] (https://github.com/garden/tree) into `/home/dom/tree/`.
- Copy `redirect.js` into `/home/dom/tree/`.
- Install the `redirect`, `tree` and `warden` scripts into `/etc/init.d/`.

## Usage

1. Start the `redirect` service first: `sudo service redirect start`. This will redirect HTTP traffic to HTTPS.
2. Then start the `warden` service: `sudo service warden start`. This will automatically start and watch the `tree` service.
