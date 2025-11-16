apt install ufw
ufw default deny incoming
ufw default allow outgoing
ufw allow from 192.168.1.0/24
ufw allow from 192.168.0.0/24
ufw allow from 192.168.31.0/24
ufw allow from 172.31.0.0/24
ufw allow 6666/tcp
ufw enable
ufw status verbose
systemctl enable ufw
systemctl restart ufw
