function ros_source --description "Lazy-load ROS Jazzy environment"
    if set -q ROS_DISTRO
        echo "ROS $ROS_DISTRO already loaded"
        return 0
    end

    set -l setup /opt/ros/jazzy/setup.bash
    if not test -f $setup
        echo "ROS setup not found: $setup" >&2
        return 1
    end

    # Source ROS in bash, capture resulting environment as null-delimited pairs
    set -l ros_env (bash -c "source $setup 2>/dev/null && env -0" 2>/dev/null | string split0)

    for entry in $ros_env
        set -l kv (string split -m 1 '=' $entry)
        test (count $kv) -ge 2; or continue
        set -l k $kv[1]
        set -l v $kv[2]

        switch $k
            case PATH
                # Merge: add any new entries that aren't already in fish's PATH
                for p in (string split ':' $v)
                    contains -- $p $PATH; or fish_add_path --global --prepend $p
                end
            case PYTHONPATH LD_LIBRARY_PATH CMAKE_PREFIX_PATH AMENT_PREFIX_PATH COLCON_PREFIX_PATH
                set -gx $k $v
            case 'ROS_*' 'AMENT_*' 'COLCON_*' 'RCUTILS_*' 'RCL_*' 'CYCLONEDDS_*' 'FASTRTPS_*'
                set -gx $k $v
        end
    end

    echo "ROS Jazzy loaded (distro: $ROS_DISTRO)"
end
