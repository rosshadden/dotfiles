# Stuff about my various game personas.
export def main [] {}

# Query slippi.gg to get Melee data.
export def slippi [] {
	const api = "https://gql-gateway-2-dot-slippi.uc.r.appspot.com/graphql"
	const payload = {
		operationName: "AccountManagementPageQuery",
		variables: {
			cc: "RAWS#790",
			uid: "RAWS#790",
		},
		query: `
			fragment profileFieldsV2 on NetplayProfileV2 {
				id
				ratingOrdinal
				ratingUpdateCount
				wins
				losses
				dailyGlobalPlacement
				dailyRegionalPlacement
				continent
				characters {
					id
					character
					gameCount
				}
			}

			fragment userProfilePage on User {
				displayName
				connectCode {
					code
				}
				status
				activeSubscription {
					level
					hasGiftSub
				}
				rankedNetplayProfile {
					...profileFields
				}
			}

			query AccountManagementPageQuery($cc: String!, $uid: String!) {
				getUser(fbUid: $uid) {
					...userProfilePage
				}
				getConnectCode(code: $cc) {
					user {
						...userProfilePage
					}
				}
			}
		`
	}

	# $payload | http post -t application/json $api | get data.getConnectCode.user
	$payload
}
