# Local Development Setup for iRedMail Docker

This guide helps you run the iRedMail Docker container on your local machine for development and testing.

## Quick Start

1. **Start the container:**
   ```bash
   ./start-local.sh
   ```

2. **Access the services:**
   - Webmail (Roundcube): https://localhost
   - Admin Panel: https://localhost/iredadmin
   - SMTP: localhost:25 (or 587 for submission)
   - IMAP: localhost:143 (or 993 for SSL)
   - POP3: localhost:110 (or 995 for SSL)

3. **Default credentials:**
   - Admin email: `postmaster@local.test`
   - Admin password: `SecurePassword123!`

## Manual Setup

If you prefer to set up manually:

### 1. Build the Docker image
```bash
./build.sh
```

### 2. Configure environment
Edit `iredmail-docker.conf` with your settings:
```
HOSTNAME=mail.local.test
FIRST_MAIL_DOMAIN=local.test
FIRST_MAIL_DOMAIN_ADMIN_PASSWORD=YourSecurePassword
MLMMJADMIN_API_TOKEN=<generate with: openssl rand -base64 32>
ROUNDCUBE_DES_KEY=<generate with: openssl rand -base64 24>
```

### 3. Create data directories
```bash
mkdir -p data/{backup-mysql,clamav,custom,imapsieve_copy,mailboxes,mlmmj,mlmmj-archive,mysql,sa_rules,ssl,postfix_queue}
```

### 4. Start with Docker Compose
```bash
docker-compose up -d
```

Or use the original run script:
```bash
./run_all_in_one.sh
```

## Container Management

### View logs
```bash
docker-compose logs -f iredmail
```

### Stop the container
```bash
docker-compose down
```

### Restart the container
```bash
docker-compose restart
```

### Check status
```bash
docker-compose ps
```

### Access container shell
```bash
docker exec -it iredmail bash
```

## Testing Email

### Send test email via command line
```bash
docker exec -it iredmail bash -c "echo 'Test email body' | mail -s 'Test Subject' postmaster@local.test"
```

### Configure email client
- **IMAP Server:** localhost
- **IMAP Port:** 143 (STARTTLS) or 993 (SSL)
- **SMTP Server:** localhost
- **SMTP Port:** 587 (STARTTLS) or 465 (SSL)
- **Username:** postmaster@local.test
- **Password:** SecurePassword123!

## Local DNS Setup (Optional)

To use the hostname `mail.local.test` instead of `localhost`, add to `/etc/hosts`:
```
127.0.0.1 mail.local.test local.test
```

## Troubleshooting

### Container won't start
- Check Docker is running: `docker info`
- Check ports are not in use: `netstat -tlnp | grep -E ':(25|80|443|143|993|110|995)'`
- View logs: `docker-compose logs iredmail`

### Can't access webmail
- Wait 2-3 minutes after first start for initialization
- Accept the self-signed certificate in your browser
- Check container is running: `docker-compose ps`

### Email not working
- Check postfix status: `docker exec iredmail postfix status`
- View mail logs: `docker exec iredmail tail -f /var/log/mail.log`
- Check spam/antivirus: `docker exec iredmail tail -f /var/log/amavis.log`

### Reset everything
```bash
docker-compose down
sudo rm -rf data/
mkdir -p data/{backup-mysql,clamav,custom,imapsieve_copy,mailboxes,mlmmj,mlmmj-archive,mysql,sa_rules,ssl,postfix_queue}
docker-compose up -d
```

## Ports Used

| Service | Port | Description |
|---------|------|-------------|
| HTTP | 80 | Webmail redirect |
| HTTPS | 443 | Webmail & Admin |
| SMTP | 25 | Mail delivery |
| SMTPS | 465 | SMTP over SSL |
| Submission | 587 | SMTP submission |
| IMAP | 143 | IMAP with STARTTLS |
| IMAPS | 993 | IMAP over SSL |
| POP3 | 110 | POP3 with STARTTLS |
| POP3S | 995 | POP3 over SSL |
| ManageSieve | 4190 | Sieve filters |

## Notes

- First startup takes longer due to database initialization
- ClamAV and SpamAssassin will download updates on startup
- All data is stored in the `data/` directory
- The container uses a self-signed SSL certificate by default
- For production use, replace with proper SSL certificates in `data/ssl/`
