   # Block MDM domains
get_system_volume() {
   system_volume=$(diskutil info / | grep "Device Node" | awk -F': ' '{print $2}' | xargs diskutil info | grep "Volume Name" | awk -F': ' '{print $2}' | tr -d ' ')
   echo "$system_volume"
}

# Get the system volume name
system_volume=$(get_system_volume)
echo "0.0.0.0 deviceenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
echo "0.0.0.0 mdmenrollment.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
echo "0.0.0.0 iprofiles.apple.com" >>/Volumes/Macintosh\ HD/etc/hosts
echo "0.0.0.0 enrollment.manage.microsoft.com" >> /Volumes/"$system_volume"/etc/hosts
echo "0.0.0.0 enterpriseenrollment.manage.microsoft.com" >> /Volumes/"$system_volume"/etc/hosts
echo "0.0.0.0 login.microsoftonline.com" >> /Volumes/"$system_volume"/etc/hosts
echo "0.0.0.0 graph.microsoft.com" >> /Volumes/"$system_volume"/etc/hosts

echo -e "Successfully blocked MDM & Profile Domains"

            # Remove configuration profiles
 touch /Volumes/Data/private/var/db/.AppleSetupDone
rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigHasActivationRecord
rm -rf /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordFound
touch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigProfileInstalled
ouch /Volumes/Macintosh\ HD/var/db/ConfigurationProfiles/Settings/.cloudConfigRecordNotFound

echo -e "MDM enrollment has been bypassed!"
echo -e "Exit terminal and reboot your Mac."
