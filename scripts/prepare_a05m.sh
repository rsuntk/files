rcd() {
  local url="$1"
  local path="$2"
  local branch="$3"

  # Remove .git to make repo sync happy
  rm -rf $path; git clone $url --depth=1 -b $branch $path; rm -rf $path/.git
}

# ssh key is needed
git clone --depth=1 git@github.com:a05m-Internal-testing/a05m_source.git

# copy
mv a05m_source/device/* device/
mv a05m_source/vendor/* vendor/

# cleanup the rest
rm -rf a05m_source

# dependencies
rcd https://github.com/LineageOS/android_device_mediatek_sepolicy_vndr.git device/mediatek/sepolicy_vndr lineage-23.2
rcd https://github.com/crdroidandroid/android_hardware_mediatek.git hardware/mediatek 16.0
rcd https://github.com/LineageOS/android_hardware_samsung.git hardware/samsung lineage-23.2
rcd https://github.com/LineageOS/android_hardware_samsung_nfc.git hardware/samsung/nfc lineage-23.2

# we do public keys!!
rm -rf vendor/lineage-priv/keys
git clone https://gitlab.com/rsuntk-asus-sdm660/signing_template.git vendor/lineage-priv/keys -b lineage
cd vendor/lineage-priv/keys && bash $(pwd)/keys.sh
cd -
