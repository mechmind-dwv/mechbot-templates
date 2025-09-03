# Comando completo para flasheo seguro
./deploy_firmware.sh \
  --target=jetson-agx-orin \
  --image=firmware_v2.1.8.signed.img \
  --verify-signature \
  --backup=create
