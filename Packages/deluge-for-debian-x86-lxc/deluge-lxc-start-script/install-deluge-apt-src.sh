#!/bin/bash

cat <<EOF >> /root/warhammer-repo-key
-----BEGIN PGP PUBLIC KEY BLOCK-----
Version: GnuPG v1.4.5 (GNU/Linux)

mQENBFKOGu0BCACkC+gjShMU+TyO3MWqnFxiv+V0f+72VPdXN2SjcWKjqQDgZuuO
/Z0u7W+nIpPTVq3aALuUaZ5Z4cphuVkfWxP1sbY31zNuhk53PasQCmFKbhAlKwTF
KQmazcw3r3T2a1MG5lJK190MiNIiAz3Q2rcrCFnjhJJUWOdm//o/3ONLfQFtnICW
0Px3K/Z7mWyC7bnHQtXCvQy9AsCPe6NIkhcHoDKbxNpcxHl7KAtWCq+6Hm+Sn/El
i9/yFMjrJ0YqZFOOIyuTPxSKssQO7yYCASCQiDRxzOkz50J350pjxW0gnWzZKxNC
D6hjQen610vpGhBp30ehXC+0Vk+fvlgSp1jtABEBAAG0RGhvbWU6V2FyaGFtbWVy
NDBrIE9CUyBQcm9qZWN0IDxob21lOldhcmhhbW1lcjQwa0BidWlsZC5vcGVuc3Vz
ZS5vcmc+iQE8BBMBAgAmBQJWpFIiAhsDBQkINOc1BgsJCAcDAgQVAggDBBYCAwEC
HgECF4AACgkQlKhxE8qNccYIGAgAh2m3ViuNw5grp6isRf+HxDLwxh5g/8O5gEPW
Wm1AbRFj457mG0inLFIgO3hCsFlHIYTWvVWjnoM9FZlL1EQi/i+TPU/BxBuaaVGg
OxLBWqS4wkwJ+gpW1/0CrNGMlg9+tLxkhqvJzS4BXNK02aURuFUCN3Hd8ZfNdaua
cm8BIBWYgVj1/F6El959WvcN0gGGMEGqJ6QPzQRBTdBhwzGxG5HFn8UyMnaA2ZTR
tmhhCVxxAvTRaSSuMKITMXEFNih1EiMame0b3mrFMR4a/fs9vPYAJX3Rh5PmKfCs
p2X/8rjad7ZjOLMQt6ldL19fPoZANsQqkqqUvxXSnDH+bDSeU4hGBBMRAgAGBQJS
jhrtAAoJEDswEbdrnWUjkL0AoKtEjSgsN9qSNJQYngflV3Jx6XuCAJ95flboFT2r
tls9CMwqZ5mF2FA8/w==
=d2Ma
-----END PGP PUBLIC KEY BLOCK-----
EOF

apt-key add /root/warhammer-repo-key

echo "deb http://download.opensuse.org/repositories/home:/Warhammer40k:/ubuntu/xUbuntu_16.04 ./" >> /etc/apt/sources.list

