# 🚀 Quick Start - iRedMail Docker Local Setup

## ✅ Setup Complete!

Your iRedMail Docker container is now running on your local machine.

## 📋 Access Information

### Web Interfaces
- **Webmail (Roundcube):** https://localhost or https://mail.local.test
- **Admin Panel:** https://localhost/iredadmin or https://mail.local.test/iredadmin

### Email Server
- **Hostname:** mail.local.test
- **Domain:** local.test

### Login Credentials
- **Admin Email:** postmaster@local.test
- **Admin Password:** SecurePassword123!

## 🛠️ Quick Commands

### Check Status
```bash
docker compose ps
```

### View Logs
```bash
docker compose logs -f
```

### Stop Container
```bash
docker compose down
```

### Restart Container
```bash
docker compose restart
```

### Start Container
```bash
./start-local.sh
# or
docker compose up -d
```

## 📧 Test Email

### Send test email from container
```bash
docker exec -it iredmail bash -c "echo 'Test message' | mail -s 'Test' postmaster@local.test"
```

### Configure Email Client
- **IMAP:** localhost:143 (STARTTLS) or localhost:993 (SSL)
- **SMTP:** localhost:587 (STARTTLS) or localhost:465 (SSL)
- **Username:** postmaster@local.test
- **Password:** SecurePassword123!

## ⚠️ Important Notes

1. **SSL Certificate:** The server uses a self-signed certificate. You'll need to accept it in your browser.
2. **First Start:** The initial startup takes longer due to database initialization and downloading antivirus/antispam updates.
3. **Data Persistence:** All data is stored in the `data/` directory.

## 📚 More Information

- See `LOCAL_SETUP.md` for detailed setup instructions
- See `README.md` for general iRedMail Docker documentation
- Check logs if you encounter issues: `docker compose logs iredmail`

## 🎉 Ready to Use!

Your mail server is now operational. You can:
1. Access the webmail at https://localhost
2. Log in with postmaster@local.test
3. Create new email accounts via the admin panel
4. Send and receive emails locally
