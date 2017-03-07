#!/system/bin/sh
# Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

target=`getprop ro.board.platform`
bootmode=`getprop ro.boot.mode`
is_battery=`cat sys/class/power_supply/battery/present`

function configure_memory_parameters() {
    # Set Memory paremeters.
    #
    # Set per_process_reclaim tuning parameters
    # 2GB 64-bit will have aggressive settings when compared to 1GB 32-bit
    # 1GB and less will use vmpressure range 50-70, 2GB will use 10-70
    # 1GB and less will use 512 pages swap size, 2GB will use 1024
    #
    # Set Low memory killer minfree parameters
    # 32 bit all memory configurations will use 15K series
    # 64 bit up to 2GB with use 14K, and above 2GB will use 18K
    #
    # Set ALMK parameters (usually above the highest minfree values)
    # 32 bit will have 53K & 64 bit will have 81K
    #
    # Set ZCache parameters
    # max_pool_percent is the percentage of memory that the compressed pool
    # can occupy.
    # clear_percent is the percentage of memory at which zcache starts
    # evicting compressed pages. This should be slighlty above adj0 value.
    # clear_percent = (adj0 * 100 / avalible memory in pages)+1
    #
    arch_type=`uname -m`
    MemTotalStr=`cat /proc/meminfo | grep MemTotal`
    MemTotal=${MemTotalStr:16:8}
    MemTotalPg=$((MemTotal / 4))
    adjZeroMinFree=18432
    echo 1 > /sys/module/process_reclaim/parameters/enable_process_reclaim
    echo 70 > /sys/module/process_reclaim/parameters/pressure_max
    echo 30 > /sys/module/process_reclaim/parameters/swap_opt_eff
    echo 1 > /sys/module/lowmemorykiller/parameters/enable_adaptive_lmk
    if [ "$arch_type" == "aarch64" ] && [ $MemTotal -gt 2097152 ]; then
        echo 10 > /sys/module/process_reclaim/parameters/pressure_min
        echo 1024 > /sys/module/process_reclaim/parameters/per_swap_size
        echo "18432,23040,27648,32256,55296,80640" > /sys/module/lowmemorykiller/parameters/minfree
        echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
        adjZeroMinFree=18432
    elif [ "$arch_type" == "aarch64" ] && [ $MemTotal -gt 1048576 ]; then
        echo 10 > /sys/module/process_reclaim/parameters/pressure_min
        echo 1024 > /sys/module/process_reclaim/parameters/per_swap_size
        echo "14746,18432,22118,25805,40000,55000" > /sys/module/lowmemorykiller/parameters/minfree
        echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
        adjZeroMinFree=14746
    elif [ "$arch_type" == "aarch64" ]; then
        echo 50 > /sys/module/process_reclaim/parameters/pressure_min
        echo 512 > /sys/module/process_reclaim/parameters/per_swap_size
        echo "14746,18432,22118,25805,40000,55000" > /sys/module/lowmemorykiller/parameters/minfree
        echo 81250 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
        adjZeroMinFree=14746
    else
        echo 50 > /sys/module/process_reclaim/parameters/pressure_min
        echo 512 > /sys/module/process_reclaim/parameters/per_swap_size
        #LGE remove qcom default value to change minfree
        #echo "15360,19200,23040,26880,34415,43737" > /sys/module/lowmemorykiller/parameters/minfree
        echo 53059 > /sys/module/lowmemorykiller/parameters/vmpressure_file_min
        adjZeroMinFree=15360
    fi
    clearPercent=$((((adjZeroMinFree * 100) / MemTotalPg) + 1))
    echo $clearPercent > /sys/module/zcache/parameters/clear_percent
    echo 30 >  /sys/module/zcache/parameters/max_pool_percent
}


if [ -f /sys/devices/soc0/hw_platform ]; then
    hw_platform=`cat /sys/devices/soc0/hw_platform`
else
    hw_platform=`cat /sys/devices/system/soc/soc0/hw_platform`
fi

# Start Host based Touch processing
case "$hw_platform" in
"MTP" | "Surf" | "RCM" )
    start hbtp
    ;;
esac

# Apply Scheduler and Governor settings for 8937

# HMP scheduler settings
echo 3 > /proc/sys/kernel/sched_window_stats_policy
echo 3 > /proc/sys/kernel/sched_ravg_hist_size
echo 20000000 > /proc/sys/kernel/sched_ravg_window

# HMP Task packing settings
echo 20 > /proc/sys/kernel/sched_small_task
echo 30 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_load
echo 30 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_load

echo 3 > /sys/devices/system/cpu/cpu0/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu1/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu2/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu3/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu4/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu5/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu6/sched_mostly_idle_nr_run
echo 3 > /sys/devices/system/cpu/cpu7/sched_mostly_idle_nr_run

echo 0 > /sys/devices/system/cpu/cpu0/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu1/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu2/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu3/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu4/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu5/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu6/sched_prefer_idle
echo 0 > /sys/devices/system/cpu/cpu7/sched_prefer_idle

for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor
do
    echo "cpufreq" > $devfreq_gov
done

for devfreq_gov in /sys/class/devfreq/soc:qcom,cpubw/governor
do
    echo "bw_hwmon" > $devfreq_gov
    for cpu_io_percent in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/io_percent
    do
        echo 20 > $cpu_io_percent
    done
for cpu_guard_band in /sys/class/devfreq/soc:qcom,cpubw/bw_hwmon/guard_band_mbps
    do
        echo 30 > $cpu_guard_band
    done
done

for gpu_bimc_io_percent in /sys/class/devfreq/soc:qcom,gpubw/bw_hwmon/io_percent
do
    echo 40 > $gpu_bimc_io_percent
done
# disable thermal core_control to update interactive gov settings
echo 0 > /sys/module/msm_thermal/core_control/enabled

# enable governor for perf cluster
echo 1 > /sys/devices/system/cpu/cpu0/online
echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
echo "19000 1094400:39000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 85 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 1094400 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
echo "1 960000:85 1094400:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 40000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq

# enable governor for power cluster
if [ "$is_battery" != "0" ]; then
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
    echo 39000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
    echo 90 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
    echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
    echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
    echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
    echo "1 768000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
    echo 40000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
    echo 768000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
fi
# lge_over_write : this setting changed Pre-CS2, LGE over-write in order to use previous setting.
# echo "1 998400:85 1094400:90 1344000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
# echo 998400 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
# echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
# echo "1 806400:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
# echo 806400 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq

# lge_add : input boost for touch performance
echo "0:1248000 1:1248000 2:1248000 3:1248000 4:1094400 5:1094400 6:1094400 7:1094400" > /sys/module/cpu_boost/parameters/input_boost_freq

# re-enable thermal & BCL core_control now
# re-enable thermal core_control now
echo 1 > /sys/module/msm_thermal/core_control/enabled

# Bring up all cores online
echo 1 > /sys/devices/system/cpu/cpu1/online
echo 1 > /sys/devices/system/cpu/cpu2/online
echo 1 > /sys/devices/system/cpu/cpu3/online
if [ "$is_battery" != "0" ]; then
    echo 1 > /sys/devices/system/cpu/cpu4/online
    echo 1 > /sys/devices/system/cpu/cpu5/online
    echo 1 > /sys/devices/system/cpu/cpu6/online
    echo 1 > /sys/devices/system/cpu/cpu7/online
fi

# Disable L2 GDHS modes
echo N > /sys/module/lpm_levels/system/pwr/pwr-l2-gdhs/idle_enabled
echo N > /sys/module/lpm_levels/system/perf/perf-l2-gdhs/idle_enabled

# Enable low power modes
echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled

# HMP scheduler (big.Little cluster related) settings
echo 93 > /proc/sys/kernel/sched_upmigrate
echo 83 > /proc/sys/kernel/sched_downmigrate

# Enable sched guided freq control
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
echo 50000 > /proc/sys/kernel/sched_freq_inc_notify
echo 50000 > /proc/sys/kernel/sched_freq_dec_notify

# Enable core control
if [ "$bootmode" == "qem_130k" ]; then
    echo 0 > /sys/module/msm_thermal/core_control/enabled
elif [ "$is_battery" == "0" ]; then
    echo 0 > /sys/module/msm_thermal/core_control/enabled
else
    insmod /system/lib/modules/core_ctl.ko
    echo 2 > /sys/devices/system/cpu/cpu0/core_ctl/min_cpus
    echo 4 > /sys/devices/system/cpu/cpu0/core_ctl/max_cpus
    echo 68 > /sys/devices/system/cpu/cpu0/core_ctl/busy_up_thres
    echo 40 > /sys/devices/system/cpu/cpu0/core_ctl/busy_down_thres
    echo 100 > /sys/devices/system/cpu/cpu0/core_ctl/offline_delay_ms
    echo 1 > /sys/devices/system/cpu/cpu0/core_ctl/is_big_cluster
fi

# Enable dynamic clock gating
echo 1 > /sys/module/lpm_levels/lpm_workarounds/dynamic_clock_gating
# Enable timer migration to little cluster
echo 1 > /proc/sys/kernel/power_aware_timer_migration
# Set Memory parameters
configure_memory_parameters
# lge_add : Disable sched_boost
echo 0 > /proc/sys/kernel/sched_boost

chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_rate
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/sampling_down_factor
chown -h system /sys/devices/system/cpu/cpufreq/ondemand/io_is_busy

# Post-setup services
echo 128 > /sys/block/mmcblk0/bdi/read_ahead_kb
echo 128 > /sys/block/mmcblk0/queue/read_ahead_kb
echo 128 > /sys/block/dm-0/queue/read_ahead_kb
echo 128 > /sys/block/dm-1/queue/read_ahead_kb
rm /data/system/perfd/default_values
start perfd

# Let kernel know our image version/variant/crm_version
if [ -f /sys/devices/soc0/select_image ]; then
    image_version="10:"
    image_version+=`getprop ro.build.id`
    image_version+=":"
    image_version+=`getprop ro.build.version.incremental`
    image_variant=`getprop ro.product.name`
    image_variant+="-"
    image_variant+=`getprop ro.build.type`
    oem_version=`getprop ro.build.version.codename`
    echo 10 > /sys/devices/soc0/select_image
    echo $image_version > /sys/devices/soc0/image_version
    echo $image_variant > /sys/devices/soc0/image_variant
    echo $oem_version > /sys/devices/soc0/image_crm_version
fi
