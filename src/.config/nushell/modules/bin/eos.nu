#!/usr/bin/env nu

const api = "http://10.0.0.20:8123/api"

def request [endpoint: string, payload?: record] {
	if $payload == null {
		http get -H [Authorization $"Bearer (cat ~/Documents/certs/ha.cert)"] $"($api)($endpoint)"
	} else {
		http post -t application/json -H [Authorization $"Bearer (cat ~/Documents/certs/ha.cert)"] $"($api)($endpoint)" $payload
	}
}

export def main [
	state?: string, # off | free | focus | busy
	--format (-f): string, # json
] {
	const entity = "select.eos_status"
	mut res = null

	if $state == null {
		$res = (request $"/states/($entity)")
	} else if not ($state in [off free focus busy]) {
		error make { msg: "invalid state" }
	} else {
		$res = (request $"/states/($entity)" {
			state: $state,
		})
	}

	$res | match $format {
		json => ($res | to json -r),
		_ => {},
	}
}

export def led [
	color?: string,
	--format (-f): string, # json
] {
	const entity = "light.eos_rgb_led"
	mut res = null

	if $color == null {
		$res = (request $"/states/($entity)")
	} else {
		$res = (request $"/services/light/turn_on" {
			entity_id: $entity,
			color_name: $color,
		})
	}

	match $format {
		json => ($res | to json -r),
		_ => $res,
	}
}
