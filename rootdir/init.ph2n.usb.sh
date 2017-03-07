#!/system/bin/sh

#
# Allow USB enumeration with default PID/VID
#
if [ -e /sys/class/android_usb/f_mass_storage/lun/nofua ];
then
    echo 1  > /sys/class/android_usb/f_mass_storage/lun/nofua
fi
if [ -e /sys/class/android_usb/f_cdrom_storage/lun/nofua ];
then
    echo 1  > /sys/class/android_usb/f_cdrom_storage/lun/nofua
fi
if [ -e /sys/class/android_usb/f_mass_storage/rom/nofua ];
then
    echo 1  > /sys/class/android_usb/f_mass_storage/rom/nofua
fi

usb_config=`getprop persist.sys.usb.config`
case "$usb_config" in
    "" | "pc_suite" | "mtp_only" | "auto_conf")
        setprop persist.sys.usb.config mtp
        ;;
    "adb" | "pc_suite,adb" | "mtp_only,adb" | "auto_conf,adb")
        setprop persist.sys.usb.config mtp,adb
        ;;
    "ptp_only")
        setprop persist.sys.usb.config ptp
        ;;
    "ptp_only,adb")
        setprop persist.sys.usb.config ptp,adb
        ;;
    * ) ;; #USB persist config exists, do nothing
esac

################################################################################
# QCOM
################################################################################

chown -h root.system /sys/devices/platform/msm_hsusb/gadget/wakeup
chmod -h 220 /sys/devices/platform/msm_hsusb/gadget/wakeup

# Set platform variables
if [ -f /sys/devices/soc0/hw_platform ]; then
    soc_hwplatform=`cat /sys/devices/soc0/hw_platform` 2> /dev/null
else
    soc_hwplatform=`cat /sys/devices/system/soc/soc0/hw_platform` 2> /dev/null
fi

# Get hardware revision
if [ -f /sys/devices/soc0/revision ]; then
    soc_revision=`cat /sys/devices/soc0/revision` 2> /dev/null
else
    soc_revision=`cat /sys/devices/system/soc/soc0/revision` 2> /dev/null
fi

#
# Check ESOC for external MDM
#
# Note: currently only a single MDM is supported
#
if [ -d /sys/bus/esoc/devices ]; then
for f in /sys/bus/esoc/devices/*; do
    if [ -d $f ]; then
        if [ `grep "^MDM" $f/esoc_name` ]; then
            esoc_link=`cat $f/esoc_link`
            break
        fi
    fi
done
fi

target=`getprop ro.board.platform`

# Allow USB enumeration with default PID/VID
baseband=`getprop ro.baseband`
echo 1  > /sys/class/android_usb/f_mass_storage/lun/nofua
usb_config=`getprop persist.sys.usb.config`
case "$usb_config" in
    "" | "adb") #USB persist config not set, select default configuration
      case "$esoc_link" in
          "HSIC")
              setprop persist.sys.usb.config diag,diag_mdm,serial_hsic,serial_tty,rmnet_hsic,mass_storage,adb
              setprop persist.rmnet.mux enabled
          ;;
          "HSIC+PCIe")
              setprop persist.sys.usb.config diag,diag_mdm,serial_hsic,rmnet_qti_ether,mass_storage,adb
          ;;
          "PCIe")
              setprop persist.sys.usb.config diag,diag_mdm,serial_cdev,rmnet_qti_ether,mass_storage,adb
          ;;
          *)
          case "$baseband" in
              "mdm")
                   setprop persist.sys.usb.config diag,diag_mdm,serial_hsic,serial_tty,rmnet_hsic,mass_storage,adb
              ;;
              "mdm2")
                   setprop persist.sys.usb.config diag,diag_mdm,serial_hsic,serial_tty,rmnet_hsic,mass_storage,adb
              ;;
              "sglte")
                   setprop persist.sys.usb.config diag,diag_qsc,serial_smd,serial_tty,serial_hsuart,rmnet_hsuart,mass_storage,adb
              ;;
              "dsda" | "sglte2")
                   setprop persist.sys.usb.config diag,diag_mdm,diag_qsc,serial_hsic,serial_hsuart,rmnet_hsic,rmnet_hsuart,mass_storage,adb
              ;;
              "dsda2")
                   setprop persist.sys.usb.config diag,diag_mdm,diag_mdm2,serial_hsic,serial_hsusb,rmnet_hsic,rmnet_hsusb,mass_storage,adb
              ;;
              *)
          esac
          ;;
      esac
    ;;
    * ) ;; #USB persist config exists, do nothing
esac

# check configfs is mounted or not
if [ -d /config/usb_gadget ]; then
    bootmode=`getprop ro.bootmode`
    case "$bootmode" in
        "qem_56k" | "qem_910k" | "pif_56k" | "pif_910k")
            setprop sys.usb.config factory
            ;;
        "qem_130k" | "pif_130k")
            setprop sys.usb.config factory2
            ;;
        *)
            ;;
    esac
    setprop sys.usb.configfs 1
fi

setprop persist.sys.usb.config diag,serial_smd,rmnet_qti_bam,adb

#
# set module params for embedded rmnet devices
#
rmnetmux=`getprop persist.rmnet.mux`
case "$baseband" in
    "mdm" | "dsda" | "sglte2")
        case "$rmnetmux" in
            "enabled")
                    echo 1 > /sys/module/rmnet_usb/parameters/mux_enabled
                    echo 8 > /sys/module/rmnet_usb/parameters/no_fwd_rmnet_links
                    echo 17 > /sys/module/rmnet_usb/parameters/no_rmnet_insts_per_dev
            ;;
        esac
        echo 1 > /sys/module/rmnet_usb/parameters/rmnet_data_init
        # Allow QMUX daemon to assign port open wait time
        chown -h radio.radio /sys/devices/virtual/hsicctl/hsicctl0/modem_wait
    ;;
    "dsda2")
          echo 2 > /sys/module/rmnet_usb/parameters/no_rmnet_devs
          echo hsicctl,hsusbctl > /sys/module/rmnet_usb/parameters/rmnet_dev_names
          case "$rmnetmux" in
               "enabled") #mux is neabled on both mdms
                      echo 3 > /sys/module/rmnet_usb/parameters/mux_enabled
                      echo 8 > /sys/module/rmnet_usb/parameters/no_fwd_rmnet_links
                      echo 17 > write /sys/module/rmnet_usb/parameters/no_rmnet_insts_per_dev
               ;;
               "enabled_hsic") #mux is enabled on hsic mdm
                      echo 1 > /sys/module/rmnet_usb/parameters/mux_enabled
                      echo 8 > /sys/module/rmnet_usb/parameters/no_fwd_rmnet_links
                      echo 17 > /sys/module/rmnet_usb/parameters/no_rmnet_insts_per_dev
               ;;
               "enabled_hsusb") #mux is enabled on hsusb mdm
                      echo 2 > /sys/module/rmnet_usb/parameters/mux_enabled
                      echo 8 > /sys/module/rmnet_usb/parameters/no_fwd_rmnet_links
                      echo 17 > /sys/module/rmnet_usb/parameters/no_rmnet_insts_per_dev
               ;;
          esac
          echo 1 > /sys/module/rmnet_usb/parameters/rmnet_data_init
          # Allow QMUX daemon to assign port open wait time
          chown -h radio.radio /sys/devices/virtual/hsicctl/hsicctl0/modem_wait
    ;;
esac

# Initialize RNDIS Diag option. If unset, set it to 'none'.
diag_extra=`getprop persist.sys.usb.config.extra`
if [ "$diag_extra" == "" ]; then
	setprop persist.sys.usb.config.extra none
fi

# enable rps cpus on msm8937 target
setprop sys.usb.rps_mask 40

echo qti,bam > /sys/class/android_usb/android0/f_rmnet/transports
echo 10 > /sys/module/g_android/parameters/rndis_dl_max_pkt_per_xfer
echo 3 > /sys/module/g_android/parameters/rndis_ul_max_pkt_per_xfer

