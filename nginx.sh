read -p "Enter a domain: " domain
echo "Your Website: $domain"
read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

sed -i "s/example.com/$domain/g" nginx.conf

mkdir /usr/local/ssl
cat private.key > /usr/local/ssl/private.key
cat $domain-ca.crt > /usr/local/ssl/$domain-ca.crt

mkdir /var/www/$domain
cat nginx.conf > /etc/nginx/sites-available/$domain
ln -s /etc/nginx/sites-available/$domain /etc/nginx/sites-enabled/$domain

rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default

systemctl restart nginx
systemctl status nginx