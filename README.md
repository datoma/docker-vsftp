## Usage
    docker run --name vsftpd -d -p 21:21 -p 21000-21010:21000-21010 -e FTPUSER="ftpuser|ftppassword" -e FTPSERVERADDRESS=ftp.host.de datoma/vsftpd

## Configuration

Environment variables:
- `FTPUSER` - space and `|` separated list (optional, default: `ftp|alpineftp`)
  - format `name1|password1|[folder1][|uid1] name2|password2|[folder2][|uid2]`
- `FTPSERVERADDRESS` - external address witch clients can connect passive ports (optional)
- `MIN_PORT` - minamal port number may be used for passive connections (optional, default `21000`)
- `MAX_PORT` - maximal port number may be used for passive connections (optional, default `21010`)

## USERS examples

- `user|password foo|bar|/home/foo`
- `user|password|/home/user/dir|10000`
- `user|password||10000`
