# Internxt Home Assistant Add-ons

This repository contains Home Assistant add-ons for Internxt services.

## Add-ons

### [Internxt WebDAV](./internxt-webdav)

Mount your Internxt Drive as a WebDAV server for easy file access.

## Installation

1. Navigate to **Settings** -> **Add-ons** -> **Add-on Store**
2. Click the menu icon (three dots) in the top right
3. Select **Repositories**
4. Add this repository: `https://github.com/MyUncleSam/hassio-addons`
5. The add-on will appear in the store

## Configuration

1. Make sure you set the webdav port the same as the network port in the configuration
3. Add the webdav intergration and a new connection: https://www.home-assistant.io/integrations/webdav
  - URL: `http://127.0.0.1:3005` (replace 3005 with your webdav port)
  - Username: `the username you set in the configuration`
  - Password: `the password you set in the configuration`
  - Backup path: `choose any path inside your internxt storage`
  - Verify SSL: disable (not supported)
