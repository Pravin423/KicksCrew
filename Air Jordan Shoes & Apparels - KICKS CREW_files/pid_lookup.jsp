
try {
	if (typeof usi_app === 'undefined') {
		usi_app = {};
	}
	usi_app.product_data = [];
	
		usi_app.product_data[0] = {
			pid: "bq3177-006",
			productname: "Nike LeBron 17 'Infrared VI' BQ3177-006",
			image: "https://www.kickscrew.com/cdn/shop/files/main-square_5e01cf0c-332d-4194-8d14-853228d66043_1200x.jpg?v=1706606989",
			price: "AU$241",
			url: "https://www.kickscrew.com/products/nike-lebron-17-infrared-vi-bq3177-006",
			extra: "{&quot;stock&quot;:&quot;INSTOCK&quot;}",
			views: 130,
			orders: 0,
			stock: 9999
		};
	

	if (typeof usi_app.grab_sales === 'function' && typeof usi_app.product_data !== 'undefined') {
		usi_app.grab_sales(usi_app.product_data);
	}
} catch (err) {
	if (typeof usi_commons != "undefined") {
		usi_commons.report_error(err);
	}
}
