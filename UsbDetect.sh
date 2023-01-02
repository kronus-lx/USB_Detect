#!/bin/bash

STORAGE_STRING="Driver=usb-storage"

############ Toggle Function ############
function toggle_usb_power()
{
	echo '1-1' | sudo tee /sys/bus/usb/drivers/usb/unbind
}

############ Detect Function ############
function detect_usb_storage() 
{
	local __OUTPUT=$1
	
	local USB_STORAGE=$(usb-devices | grep Driver=usb-storage | awk -F " " '{print $10}')
	
	eval $__OUTPUT="$USB_STORAGE"
}
############ Main Function ############ 
while true

do
	# Run Detect Function
	detect_usb_storage result
	
	# If detected close down USB Power
	case $result in

		*"$STORAGE_STRING"*)
			toggle_usb_power
			;;
	esac

	sleep 1

done
