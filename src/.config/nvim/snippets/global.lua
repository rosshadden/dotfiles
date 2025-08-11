return {

	date = {
		prefix = "date",
		body = "${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}",
		description = "Date in Y-m-D format"
	},

	diso = {
		prefix = "diso",
		body = "${CURRENT_YEAR}-${CURRENT_MONTH}-${CURRENT_DATE}T${CURRENT_HOUR}:${CURRENT_MINUTE}:${CURRENT_SECOND}",
		description = "ISO timestamp"
	},

}
