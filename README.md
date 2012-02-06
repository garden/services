# Tree Services

Service scripts for managing a secure [file tree] (https://thefiletree.com) instance.

## Description

- `redirect`: This service redirects HTTP requests to HTTPS.
- `tree`: This service runs a secure [file tree] (https://thefiletree.com) server.
- `warden`: This script watches the `tree` service, and restarts it when needed.

## Installation

- Create a user called `dom`.
- Clone [garden/tree] (https://github.com/garden/tree) into `/home/dom/tree/`.
- Copy `redirect.js` into `/home/dom/tree/`.
- Install the `redirect`, `tree` and `warden` service scripts into `/etc/init.d/`.

## Usage

1. `sudo service redirect start`: This will redirect HTTP traffic to HTTPS.
2. `sudo service warden start`: This will automatically start and watch the `tree` service for you.
