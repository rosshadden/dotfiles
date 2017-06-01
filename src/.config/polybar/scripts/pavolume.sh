#!/usr/bin/env bash

# finds the active sink for pulse audio and increments the volume. useful when you have multiple audio outputs and have a key bound to vol-up and down

osd='no'
inc='2'
capvol='no'
maxvol='200'
tmpfile='/tmp/pasink.tmp'
autosync='yes'

active_sink=`pacmd list-sinks |awk '/* index:/{print $3}'`
limit=$(expr 100 - ${inc})
maxlimit=$(expr ${maxvol} - ${inc})

function volUp {

	getCurVol

	if [ ${capvol} = 'yes' ]
	then
		if [ ${curVol} -le 100 -a ${curVol} -ge ${limit} ]
		then
			pactl set-sink-volume ${active_sink} -- 100%
		elif [ ${curVol} -lt ${limit} ]
		then
			pactl set-sink-volume ${active_sink} -- +${inc}%
		fi
	elif [ ${curVol} -le ${maxvol} -a ${curVol} -ge ${maxlimit} ]
	then
		pactl set-sink-volume ${active_sink} ${maxvol}%
	elif [ ${curVol} -lt ${maxlimit} ]
	then
		pactl set-sink-volume ${active_sink} +${inc}%
	fi

	getCurVol

	if [ ${osd} = 'yes' ]
	then
		qdbus org.kde.kded /modules/kosd showVolume ${curVol} 0
	fi

	if [ ${autosync} = 'yes' ]
	then
		volSync
	fi
}

function volDown {

	pactl set-sink-volume ${active_sink} -${inc}%
	getCurVol

	if [ ${osd} = 'yes' ]
	then
		qdbus org.kde.kded /modules/kosd showVolume ${curVol} 0
	fi

	if [ ${autosync} = 'yes' ]
	then
		volSync
	fi

}

function getSinkInputs {

	inputs=`pacmd list-sink-inputs |grep -B 4 'sink: '${1}' ' |awk '/index:/{print $2}' >${tmpfile}`
	input_array=`cat $tmpfile`
}

function volSync {

	getSinkInputs ${active_sink}
	getCurVol

	for each in ${input_array}
	do
		pactl set-sink-input-volume ${each} ${curVol}%
	done

}

function getCurVol {

	curVol=`pacmd list-sinks |grep -A 15 'index: '${active_sink}'' |grep 'volume:' |egrep -v 'base volume:' |awk -F : '{print $3}' |grep -o -P '.{0,3}%'|sed s/.$// |tr -d ' '`

}

function volMute {

	case "$1" in
		mute)
			pactl set-sink-mute ${active_sink} 1
			curVol=0
			status=1
		;;
		unmute)
			pactl set-sink-mute ${active_sink} 0
			getCurVol
			status=0
		;;
	esac

	if [ ${osd} = 'yes' ]
	then
		qdbus org.kde.kded /modules/kosd showVolume ${curVol} ${status}
	fi

}

function volMuteStatus {

	curStatus=`pacmd list-sinks |grep -A 15 'index: '${active_sink}'' |awk '/muted/{ print $2}'`

}


case "$1" in
	--up)
		volUp
	;;
	--down)
		volDown
	;;
	--togmute)
		volMuteStatus
		if [ ${curStatus} = 'yes' ]
		then
			volMute unmute
		else
			volMute mute
		fi
	;;
	--mute)
		volMute mute
	;;
	--unmute)
		volMute unmute
	;;
	--sync)
		volSync
	;;
	*)
		getCurVol
		volMuteStatus
		if [ ${curStatus} = 'yes' ]
		then
			echo " $curVol%"
		else
			echo " $curVol%"
		fi
	;;
esac
