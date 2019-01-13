var options = {
	url: "http://localhost:3000/search.json",
	listLocation: "lots",
  theme: "round",
  theme: "dark",
  list: {
		maxNumberOfElements: 5,
		match: {
			enabled: true
		}
	},
	template: {
		type: "links",
		fields: {
				link: "url"
		}
	},
	getValue: "name"
};
