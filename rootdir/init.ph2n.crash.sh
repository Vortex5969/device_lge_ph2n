#!/system/bin/sh

enable=`getprop persist.service.crash.enable`

PATH=/sbin:/system/sbin:/system/bin:/system/xbin
export PATH

case $enable in
    "1")
        echo 1 > /sys/module/msm_poweroff/parameters/download_mode
        echo 55 > /sys/module/msm_rtb/parameters/filter
        echo 1 > /sys/kernel/debug/tracing/tracing_on
        # schedular
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_cpu_hotplug/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_migrate_task/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_runtime/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_blockedenable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_iowait/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_sleep/enable
        echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_wait/enable
        # workqueue
        echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_start/enable
        echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_end/enable
        # clock
        echo 1 > /sys/kernel/debug/tracing/events/power/clock_set_rate/enable
        # regulator
        echo 1 > /sys/kernel/debug/tracing/events/regulator/enable
        # power
        echo 1 > /sys/kernel/debug/tracing/events/msm_low_power/enable
        # thermal
        echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_core_offline/enable
        echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_post_core_offline/enable
        echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_core_online/enable
        echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_post_core_online/enable
        # irq
        echo 1 > /sys/kernel/debug/tracing/events/irq/irq_handler_entry/enable
        # size
        echo 4096 > /sys/kernel/debug/tracing/buffer_size_kb
        ;;
    "0")
        echo 0 > /sys/module/msm_poweroff/parameters/download_mode
        echo 0 > /sys/module/msm_rtb/parameters/filter
        echo 0 > /sys/kernel/debug/tracing/tracing_on
        # schedular
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_cpu_hotplug/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_migrate_task/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_stat_runtime/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_stat_blockedenable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_stat_iowait/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_stat_sleep/enable
        echo 0 > /sys/kernel/debug/tracing/events/sched/sched_stat_wait/enable
        # workqueue
        echo 0 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_start/enable
        echo 0 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_end/enable
        # clock
        echo 0 > /sys/kernel/debug/tracing/events/power/clock_set_rate/enable
        # regulator
        echo 0 > /sys/kernel/debug/tracing/events/regulator/enable
        # power
        echo 0 > /sys/kernel/debug/tracing/events/msm_low_power/enable
        # thermal
        echo 0 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_core_offline/enable
        echo 0 > /sys/kernel/debug/tracing/events/thermal/thermal_post_core_offline/enable
        echo 0 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_core_online/enable
        echo 0 > /sys/kernel/debug/tracing/events/thermal/thermal_post_core_online/enable
        # irq
        echo 0 > /sys/kernel/debug/tracing/events/irq/irq_handler_entry/enable
        # size
        echo 0 > /sys/kernel/debug/tracing/buffer_size_kb
        # free buffer
        echo > /sys/kernel/debug/tracing/free_buffer
        ;;
esac

# function to enable ftrace events to CoreSight STM
enable_stm_events()
{
    # bail out if its perf config
    if [ ! -d /sys/module/msm_rtb ]
    then
        return
    fi
    # bail out if coresight isn't present
    if [ ! -d /sys/bus/coresight ]
    then
        return
    fi
    # bail out if ftrace events aren't present
    if [ ! -d /sys/kernel/debug/tracing/events ]
    then
        return
    fi

    echo 1 > /sys/bus/coresight/devices/coresight-tmc-etr/curr_sink
    echo 1 > /sys/bus/coresight/devices/coresight-stm/enable
    echo 1 > /sys/kernel/debug/tracing/tracing_on
    echo 0 > /sys/bus/coresight/devices/coresight-stm/hwevent_enable
    # timer
    echo 1 > /sys/kernel/debug/tracing/events/timer/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/filter
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_cancel/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_entry/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_expire_exit/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_init/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/timer_start/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/tick_stop/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_cancel/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_entry/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_expire_exit/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_init/enable
    echo 1 > /sys/kernel/debug/tracing/events/timer/hrtimer_start/enable
    #enble FTRACE for softirq events
    echo 1 > /sys/kernel/debug/tracing/events/irq/enable
    echo 1 > /sys/kernel/debug/tracing/events/irq/filter
    echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_entry/enable
    echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_exit/enable
    echo 1 > /sys/kernel/debug/tracing/events/irq/softirq_raise/enable
    #enble FTRACE for Workqueue events
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/enable
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/filter
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_activate_work/enable
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_end/enable
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_execute_start/enable
    echo 1 > /sys/kernel/debug/tracing/events/workqueue/workqueue_queue_work/enable
    # schedular
    echo 1 > /sys/kernel/debug/tracing/events/sched/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/filter
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_cpu_hotplug/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_cpu_load/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_enq_deq_task/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_kthread_stop_ret/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_kthread_stop/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_load_balance/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_migrate_task/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_pi_setprio/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_exec/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_exit/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_fork/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_free/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_process_wait/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_blocked/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_iowait/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_runtime/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_sleep/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_stat_wait/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_switch/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_task_load/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_update_history/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_update_task_ravg/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wait_task/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_wakeup_new/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_get_busy/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_get_nr_running_avg/enable
    echo 1 > /sys/kernel/debug/tracing/events/sched/sched_reset_all_window_stats/enable
    # sound
    echo 1 > /sys/kernel/debug/tracing/events/asoc/snd_soc_reg_read/enable
    echo 1 > /sys/kernel/debug/tracing/events/asoc/snd_soc_reg_write/enable
    # mdp
    echo 1 > /sys/kernel/debug/tracing/events/mdss/mdp_video_underrun_done/enable
    # video
    echo 1 > /sys/kernel/debug/tracing/events/msm_vidc/enable
    # clock
    echo 1 > /sys/kernel/debug/tracing/events/power/clock_set_rate/enable
    # regulator
    echo 1 > /sys/kernel/debug/tracing/events/regulator/enable
    # power
    echo 1 > /sys/kernel/debug/tracing/events/msm_low_power/enable
    #thermal
    echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_core_offline/enable
    echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_post_core_offline/enable
    echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_core_online/enable
    echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_post_core_online/enable
    echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_pre_frequency_mit/enable
    echo 1 > /sys/kernel/debug/tracing/events/thermal/thermal_post_frequency_mit/enable
}

coresight_config=`getprop persist.debug.coresight.config`

enable_dcc_config
case "$coresight_config" in
    "stm-events")
        echo "Enabling STM events."
        enable_stm_events
        ;;
    *)
        echo "Skipping coresight configuration."
        exit
        ;;
esac
