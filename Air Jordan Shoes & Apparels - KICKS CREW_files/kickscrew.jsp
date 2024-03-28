Array.prototype.filter||(Array.prototype.filter=function(t,e){"use strict";if("Function"!=typeof t&&"function"!=typeof t||!this)throw new TypeError;var r=this.length>>>0,o=new Array(r),n=this,l=0,i=-1;if(void 0===e)for(;++i!==r;)i in this&&t(n[i],i,n)&&(o[l++]=n[i]);else for(;++i!==r;)i in this&&t.call(e,n[i],i,n)&&(o[l++]=n[i]);return o.length=l,o}),Array.prototype.forEach||(Array.prototype.forEach=function(t){var e,r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if("function"!=typeof t)throw new TypeError(t+" is not a function");for(arguments.length>1&&(e=arguments[1]),r=0;r<n;){var l;r in o&&(l=o[r],t.call(e,l,r,o)),r++}}),window.NodeList&&!NodeList.prototype.forEach&&(NodeList.prototype.forEach=Array.prototype.forEach),Array.prototype.indexOf||(Array.prototype.indexOf=function(t,e){var r;if(null==this)throw new TypeError('"this" is null or not defined');var o=Object(this),n=o.length>>>0;if(0===n)return-1;var l=0|e;if(l>=n)return-1;for(r=Math.max(l>=0?l:n-Math.abs(l),0);r<n;){if(r in o&&o[r]===t)return r;r++}return-1}),document.getElementsByClassName||(document.getElementsByClassName=function(t){var e,r,o,n=document,l=[];if(n.querySelectorAll)return n.querySelectorAll("."+t);if(n.evaluate)for(r=".//*[contains(concat(' ', @class, ' '), ' "+t+" ')]",e=n.evaluate(r,n,null,0,null);o=e.iterateNext();)l.push(o);else for(e=n.getElementsByTagName("*"),r=new RegExp("(^|\\s)"+t+"(\\s|$)"),o=0;o<e.length;o++)r.test(e[o].className)&&l.push(e[o]);return l}),document.querySelectorAll||(document.querySelectorAll=function(t){var e,r=document.createElement("style"),o=[];for(document.documentElement.firstChild.appendChild(r),document._qsa=[],r.styleSheet.cssText=t+"{x-qsa:expression(document._qsa && document._qsa.push(this))}",window.scrollBy(0,0),r.parentNode.removeChild(r);document._qsa.length;)(e=document._qsa.shift()).style.removeAttribute("x-qsa"),o.push(e);return document._qsa=null,o}),document.querySelector||(document.querySelector=function(t){var e=document.querySelectorAll(t);return e.length?e[0]:null}),Object.keys||(Object.keys=function(){"use strict";var t=Object.prototype.hasOwnProperty,e=!{toString:null}.propertyIsEnumerable("toString"),r=["toString","toLocaleString","valueOf","hasOwnProperty","isPrototypeOf","propertyIsEnumerable","constructor"],o=r.length;return function(n){if("function"!=typeof n&&("object"!=typeof n||null===n))throw new TypeError("Object.keys called on non-object");var l,i,s=[];for(l in n)t.call(n,l)&&s.push(l);if(e)for(i=0;i<o;i++)t.call(n,r[i])&&s.push(r[i]);return s}}()),"function"!=typeof String.prototype.trim&&(String.prototype.trim=function(){return this.replace(/^\s+|\s+$/g,"")}),String.prototype.replaceAll||(String.prototype.replaceAll=function(t,e){return"[object regexp]"===Object.prototype.toString.call(t).toLowerCase()?this.replace(t,e):this.replace(new RegExp(t,"g"),e)}),window.hasOwnProperty=window.hasOwnProperty||Object.prototype.hasOwnProperty;
if (typeof usi_commons === 'undefined') {
	usi_commons = {
		
		debug: location.href.indexOf("usidebug") != -1 || location.href.indexOf("usi_debug") != -1,
		
		log:function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log(msg.name + ': ' + msg.message);
					} else {
						console.log.apply(console, arguments);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_error: function(msg) {
			if (usi_commons.debug) {
				try {
					if (msg instanceof Error) {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg.name + ': ' + msg.message);
					} else {
						console.log('%c USI Error:', usi_commons.log_styles.error, msg);
					}
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_success: function(msg) {
			if (usi_commons.debug) {
				try {
					console.log('%c USI Success:', usi_commons.log_styles.success, msg);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		dir:function(obj) {
			if (usi_commons.debug) {
				try {
					console.dir(obj);
				} catch(err) {
					usi_commons.report_error_no_console(err);
				}
			}
		},
		log_styles: {
			error: 'color: red; font-weight: bold;',
			success: 'color: green; font-weight: bold;'
		},
		domain: "https://app.upsellit.com",
		cdn: "https://www.upsellit.com",
		is_mobile: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()),
		device: (/iphone|ipod|ipad|android|blackberry|mobi/i).test(navigator.userAgent.toLowerCase()) ? 'mobile' : 'desktop',
		gup:function(name) {
			try {
				name = name.replace(/[\[]/, "\\\[").replace(/[\]]/, "\\\]");
				var regexS = "[\\?&]" + name + "=([^&#\\?]*)";
				var regex = new RegExp(regexS);
				var results = regex.exec(window.location.href);
				if (results == null) return "";
				else return results[1];
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_script:function(source, callback, nocache) {
			try {
				if (source.indexOf("//www.upsellit.com") == 0) source = "https:"+source;
				var docHead = document.getElementsByTagName("head")[0];
				//if (top.location != location) docHead = parent.document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				var usi_appender = "";
				if (!nocache && source.indexOf("/active/") == -1 && source.indexOf("_pixel.jsp") == -1 && source.indexOf("_throttle.jsp") == -1 && source.indexOf("metro") == -1 && source.indexOf("_suppress") == -1 && source.indexOf("product_recommendations.jsp") == -1 && source.indexOf("_pid.jsp") == -1 && source.indexOf("_zips") == -1) {
					usi_appender = (source.indexOf("?")==-1?"?":"&");
					if (source.indexOf("pv2.js") != -1) usi_appender = "%7C";
					usi_appender += "si=" + usi_commons.get_sess();
				}
				newScript.src = source + usi_appender;
				if (typeof callback == "function") {
					newScript.onload = function() {
						try {
							callback();
						} catch (e) {
							usi_commons.report_error(e);
						}
					};
				}
				docHead.appendChild(newScript);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_view:function(usiHash, usiSiteID, usiKey, callback) {
			try {
				if (typeof(usi_force) != "undefined" || location.href.indexOf("usi_force") != -1 || (usi_cookies.get("usi_sale") == null && usi_cookies.get("usi_launched") == null && usi_cookies.get("usi_launched"+usiSiteID) == null)) {
					usiKey = usiKey || "";
					var usi_append = "";
					if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
					else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
					if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
					var source = usi_commons.domain + "/view.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
					if (typeof(usi_commons.last_view) !== "undefined" && usi_commons.last_view == usiSiteID+"_"+usiKey) return;
					usi_commons.last_view = usiSiteID+"_"+usiKey;
					if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') usi_js.cleanup();
					usi_commons.load_script(source, callback);
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		remove_loads:function() {
			try {
				if (document.getElementById("usi_obj") != null) {
					document.getElementById("usi_obj").parentNode.parentNode.removeChild(document.getElementById("usi_obj").parentNode);
				}
				if (typeof(usi_commons.usi_loads) !== "undefined") {
					for (var i in usi_commons.usi_loads) {
						if (document.getElementById("usi_"+i) != null) {
							document.getElementById("usi_"+i).parentNode.parentNode.removeChild(document.getElementById("usi_"+i).parentNode);
						}
					}
				}
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load:function(usiHash, usiSiteID, usiKey, callback){
			try {
				if (typeof(window["usi_" + usiSiteID]) !== "undefined") return;
				usiKey = usiKey || "";
				var usi_append = "";
				if (usi_commons.gup("usi_force_date") != "") usi_append = "&usi_force_date=" + usi_commons.gup("usi_force_date");
				else if (typeof usi_cookies !== 'undefined' && usi_cookies.get("usi_force_date") != null) usi_append = "&usi_force_date=" + usi_cookies.get("usi_force_date");
				if (usi_commons.debug) usi_append += "&usi_referrer="+encodeURIComponent(location.href);
				var source = usi_commons.domain + "/usi_load.jsp?hash=" + usiHash + "&siteID=" + usiSiteID + "&keys=" + usiKey + usi_append;
				usi_commons.load_script(source, callback);
				if (typeof(usi_commons.usi_loads) === "undefined") {
					usi_commons.usi_loads = {};
				}
				usi_commons.usi_loads[usiSiteID] = usiSiteID;
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_precapture:function(usiQS, usiSiteID, callback) {
			try {
				if (typeof(usi_commons.last_precapture_siteID) !== "undefined" && usi_commons.last_precapture_siteID == usiSiteID) return;
				usi_commons.last_precapture_siteID = usiSiteID;
				var source = usi_commons.domain + "/hound/monitor.jsp?qs=" + usiQS + "&siteID=" + usiSiteID;
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_mail:function(qs, siteID, callback) {
			try {
				var source = usi_commons.domain + "/mail.jsp?qs=" + qs + "&siteID=" + siteID + "&domain=" + encodeURIComponent(usi_commons.domain);
				usi_commons.load_script(source, callback);
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		load_products:function(options) {
			try {
				if (!options.siteID || !options.pid) return;
				var queryStr = "";
				var params = ['siteID', 'association_siteID', 'pid', 'less_expensive', 'rows', 'days_back', 'force_exact', 'match', 'nomatch', 'name_from', 'image_from', 'price_from', 'url_from', 'extra_from', 'custom_callback', 'allow_dupe_names', 'expire_seconds', 'name', 'ordersID', 'cartsID', 'viewsID'];
				params.forEach(function(name, index){
					if (options[name]) {
						queryStr += (index == 0 ? "?" : "&") + name + '=' + options[name];
					}
				});
				if (options.filters) {
					queryStr += "&filters=" + encodeURIComponent(options.filters.join("&"));
				}
				usi_commons.load_script(usi_commons.cdn + '/utility/product_recommendations_filter_v2.jsp' + queryStr, function(){
					if (typeof options.callback === 'function') {
						options.callback();
					}
				});
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		send_prod_rec:function(siteID, info, real_time) {
			var result = false;
			try {
				if (document.getElementsByTagName("html").length > 0 && document.getElementsByTagName("html")[0].className != null && document.getElementsByTagName("html")[0].className.indexOf("translated") != -1) {
					//Ignore translated pages
					return false;
				}
				var data = [siteID, info.name, info.link, info.pid, info.price, info.image];
				if (data.indexOf(undefined) == -1) {
					var queryString = [siteID, info.name.replace(/\|/g, "&#124;"), info.link, info.pid, info.price, info.image].join("|") + "|";
					if (info.extra) queryString += info.extra + "|";
					var filetype = real_time ? "jsp" : "js";
					usi_commons.load_script(usi_commons.domain + "/utility/pv2." + filetype + "?" + encodeURIComponent(queryString));
					result = true;
				}
			} catch (e) {
				usi_commons.report_error(e);
				result = false;
			}
			return result;
		},
		report_error:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
			usi_commons.log_error(err.message);
			usi_commons.dir(err);
		},
		report_error_no_console:function(err) {
			if (err == null) return;
			if (typeof err === 'string') err = new Error(err);
			if (!(err instanceof Error)) return;
			if (typeof(usi_commons.error_reported) !== "undefined") {
				return;
			}
			usi_commons.error_reported = true;
			if (location.href.indexOf('usishowerrors') !== -1) throw err;
			else usi_commons.load_script(usi_commons.domain + '/err.jsp?oops=' + encodeURIComponent(err.message) + '-' + encodeURIComponent(err.stack) + "&url=" + encodeURIComponent(location.href));
		},
		gup_or_get_cookie: function(name, expireSeconds, forceCookie) {
			try {
				if (typeof usi_cookies === 'undefined') {
					usi_commons.log_error('usi_cookies is not defined');
					return;
				}
				expireSeconds = (expireSeconds || usi_cookies.expire_time.day);
				if (name == "usi_enable") expireSeconds = usi_cookies.expire_time.hour;
				var value = null;
				var qsValue = usi_commons.gup(name);
				if (qsValue !== '') {
					value = qsValue;
					usi_cookies.set(name, value, expireSeconds, forceCookie);
				} else {
					value = usi_cookies.get(name);
				}
				return (value || '');
			} catch (e) {
				usi_commons.report_error(e);
			}
		},
		get_sess: function() {
			var usi_si = null;
			if (typeof(usi_cookies) === "undefined") return "";
			try {
				if (usi_cookies.get('usi_si') == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_si = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_si', usi_si, 24*60*60);
					return usi_si;
				}
				if (usi_cookies.get('usi_si') != null) usi_si = usi_cookies.get('usi_si');
				usi_cookies.set('usi_si', usi_si, 24*60*60);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_si;
		},
		get_id: function(usi_append) {
			if (!usi_append) usi_append = "";
			var usi_id = null;
			try {
				if (usi_cookies.get('usi_v') == null && usi_cookies.get('usi_id'+usi_append) == null) {
					var usi_rand_str = Math.random().toString(36).substring(2);
					if (usi_rand_str.length > 6) usi_rand_str = usi_rand_str.substring(0, 6);
					usi_id = usi_rand_str + "_" + Math.round((new Date()).getTime() / 1000);
					usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
					return usi_id;
				}
				if (usi_cookies.get('usi_v') != null) usi_id = usi_cookies.get('usi_v');
				if (usi_cookies.get('usi_id'+usi_append) != null) usi_id = usi_cookies.get('usi_id'+usi_append);
				usi_cookies.set('usi_id'+usi_append, usi_id, 30 * 86400, true);
			} catch(err) {
				usi_commons.report_error(err);
			}
			return usi_id;
		},
		load_session_data: function(extended) {
			try {
				if (usi_cookies.get_json("usi_session_data") == null) {
					usi_commons.load_script(usi_commons.domain + '/utility/session_data.jsp?extended=' + (extended?"true":"false"));
				} else {
					usi_app.session_data = usi_cookies.get_json("usi_session_data");
					if (typeof(usi_app.session_data_callback) !== "undefined") {
						usi_app.session_data_callback();
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		},
		customer_ip:function(last_purchase) {
			try {
				if (last_purchase != -1) {
					usi_cookies.set("usi_suppress", "1", usi_cookies.expire_time.never);
				} else {
					usi_app.main();
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		},
		customer_check:function(company_id) {
			try {
				if (!usi_app.is_enabled && !usi_cookies.value_exists("usi_ip_checked")) {
					usi_cookies.set("usi_ip_checked", "1", usi_cookies.expire_time.day);
					usi_commons.load_script(usi_commons.domain + "/utility/customer_ip2.jsp?companyID=" + company_id);
					return false;
				}
				return true;
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	};
	setTimeout(function() {
		try {
			if (usi_commons.gup_or_get_cookie("usi_debug") != "") usi_commons.debug = true;
			if (usi_commons.gup_or_get_cookie("usi_qa") != "") {
				usi_commons.domain = usi_commons.cdn = "https://prod.upsellit.com";
			}
		} catch(err) {
			usi_commons.report_error(err);
		}
	}, 1000);
}
"undefined"==typeof usi_coupon&&(usi_coupon=function(){var e=function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)},t=function(e,t){return void 0===e?t:e},r={validateStringNotBlank:function(e,t){var r=void 0!==e;return r&&(r=e.trim().length>0),!r&&t&&usi_commons.log(t),r},validateBooleanString:function(e,t){var r=void 0!==e;return r&&(r="true"===e||"false"===e),!r&&t&&usi_commons.log(t),r},validateIntegerId:function(e,t,r){var n=parseInt(e),i=!isNaN(n)&&n>t;return!i&&r&&usi_commons.log(r),i},validateNumericString:function(e,t,r){var n=parseFloat(e),i=!isNaN(n)&&n>=t;return!i&&r&&usi_commons.log(r),i},validateRequest:function(e,t,r,n,i){var o="usi_coupon.validateRequest:  error - ";return""===n?(usi_commons.log(o+"visitorId is required"),!1):!!(""===i||this.validateIntegerId(i,-1,o+"chatId must be integer >= 0"))&&this.validateIntegerId(e,0,o+"companyId required and must be greater than 0")&&this.validateStringNotBlank(t,o+"code cannot be blank")&&this.validateBooleanString(r,o+"successful must be true or false")},validateOrderRequest:function(e,t,r,n,i,o,a){var u="usi_coupon.validateOrderRequest:  error - ";return""===r?(usi_commons.log(u+"visitorId is required"),!1):!!(""===n||this.validateIntegerId(n,-1,u+"chatId must be integer >= 0"))&&this.validateIntegerId(e,0,u+"companyId required and must be greater than 0")&&this.validateStringNotBlank(t,u+"code cannot be blank")&&this.validateNumericString(o,0,u+"orderAmt must be a number")&&this.validateNumericString(a,0,u+"discountAmt must be a number")}},n={visitorId:function(){try{return usi_commons.get_id()}catch(t){e(t)}return""},chatId:function(){return"undefined"==typeof usi_js?"":usi_js.campaign&&usi_js.campaign.id?usi_js.campaign.id:usi_cookies?t(usi_cookies.get("usi_click_id"),""):""},sessionId:function(){try{return usi_commons.get_sess()}catch(t){e(t)}return""}},i={buildReportCouponUrl:function(e,t,r,n,i,o,a,u){var c=""===n?"":"&visitorID="+encodeURIComponent(n),s=""===i?"":"&chatID="+encodeURIComponent(i),d=""===o?"":"&sessionID="+encodeURIComponent(o),l=""===a?"":"&url="+encodeURIComponent(a),p=""===u?"":"&notes="+encodeURIComponent(u),g="&coupon="+encodeURIComponent(t.trim()),h=null==usi_cookies.get("usi_coupon_utms")?"":"&utms="+encodeURIComponent(usi_cookies.get("usi_coupon_utms"));return"https://www.upsellit.com/utility/report_coupon.jsp?companyID="+encodeURIComponent(e)+c+s+d+g+"&success="+encodeURIComponent(r)+l+p+h},buildReportCouponOrderUrl:function(e,t,r,n,i,o,a,u,c,s){var d=""===r?"":"&visitorID="+encodeURIComponent(r),l=""===n?"":"&chatID="+encodeURIComponent(n),p=""===i?"":"&sessionID="+encodeURIComponent(i),g=""===c?"":"&url="+encodeURIComponent(c),h=""===s?"":"&notes="+encodeURIComponent(s),f="&orderAmt="+encodeURIComponent(o),m=""===a?"":"&orderId="+encodeURIComponent(a),v="&discountAmt="+encodeURIComponent(u),b="&coupon="+encodeURIComponent(t.trim()),y=null==usi_cookies.get("usi_coupon_utms")?"":"&utms="+encodeURIComponent(usi_cookies.get("usi_coupon_utms"));return"https://www.upsellit.com/utility/report_coupon_order.jsp?companyID="+encodeURIComponent(e)+d+l+p+b+f+m+v+g+h+y},reportCoupon:function(e,t,n,o,a,u,c,s){if(!0===n&&(n="true"),!1===n&&(n="false"),r.validateRequest(e,t,n,o,a)){var d=i.buildReportCouponUrl(e,t,n,o,a,u,c,s);usi_commons.load_script(d)}},reportCouponOrder:function(e,t,n,o,a,u,c,s,d,l){if(r.validateOrderRequest(e,t,n,o,a,u,s)){var p=i.buildReportCouponOrderUrl(e,t,n,o,a,u,c,s,d,l);usi_commons.load_script(p)}}},o={write:function(e,t,r){"undefined"!=typeof usi_cookies&&e&&usi_cookies.set("usi_cpn_mntr",JSON.stringify({code:e,success:t,discount:r}),usi_cookies.expire_time.hour,!0)},read:function(){if("undefined"==typeof usi_cookies)return{};var t=usi_cookies.get("usi_cpn_mntr");if(!t)return{};try{return JSON.parse(t)}catch(r){return e(r),{}}},delete:function(){"undefined"!=typeof usi_cookies&&usi_cookies.del("usi_cpn_mntr")}},a={record:function(e,t){"undefined"!=typeof usi_cookies&&(usi_cookies.set("usi_cms_applied",e,usi_cookies.expire_time.hour),void 0!==t&&usi_cookies.set("usi_cms_notes",t,usi_cookies.expire_time.hour))},report:function(e,t){if("undefined"!=typeof usi_cookies){var r=usi_cookies.get("usi_cms_applied");if(null!==r){usi_cookies.del("usi_cms_applied");var n=usi_cookies.get("usi_cms_notes");null!==n?usi_cookies.del("usi_cms_notes"):n="";var i="function"==typeof t?t():0;usi_coupon.report_coupon_success(e,r,i,n)}}}};return{report_coupon_success:function(e,r,a,u){try{e=t(e,0),r=t(r,"").trim();var c=n.visitorId(),s=n.chatId(),d=n.sessionId();a=t(a,0),u=t(u,""),i.reportCoupon(e,r,!0,c,s,d,window.location.href,u),o.write(r,!0,a)}catch(l){usi_commons.report_error(l)}},report_coupon_fail:function(e,r,o){try{e=t(e,0),r=t(r,"").trim();var a=n.visitorId(),u=n.chatId(),c=n.sessionId();o=t(o,""),i.reportCoupon(e,r,!1,a,u,c,window.location.href,o)}catch(s){usi_commons.report_error(s)}},report_coupon_order:function(e,r,a,u,c){try{var s=o.read();if(!s.code||!s.success){o.delete();return}e=t(e,0),r=t(r,0),a=t(a,""),u=t(u,0),c=t(c,"");var d=n.visitorId(),l=n.chatId(),p=n.sessionId(),g=u||s.discount;i.reportCouponOrder(e,s.code,d,l,p,r,a,g,window.location.href,c),o.delete()}catch(h){usi_commons.report_error(h)}},version:function(){return"5"},client_builder:function(){var e=[],t=1e3,r=-1;return{validateScrapersNotEmpty:function(){if(0===e.length)throw"No scrapers defined"},addPage:function(t){if(void 0===t||!t)throw"Invalid label: "+t;try{var n={label:"default",debug:!1,previousButton:null,previousInputField:null,scrapeDelay:1500,multiPage:!1,handleEnterLikeClick:!1,enableKeyHandler:!0,enableClickHandler:!0,enablePhantomClickCheck:!0,shouldScrapePage:function(){return!1},findButton:function(){return null},findInputField:function(){return null},scrapeDiscount:function(){return 0},isCouponInvalid:function(){return!1},scrapeFailedMessage:function(){return""},isCouponValid:function(){return!1},scrapeSuccessMessage:function(){return""},debugMessage:function(e,t){try{e.debug&&console.log("usi_coupon_monitor - "+e.label+": "+t)}catch(r){usi_commons.report_error_no_console(r)}},getCompanyId:function(){return r},impl:function(e){return{code:"",discount:0,attachClickHandler:function(e,t){if(t.enableClickHandler)try{var r=t.findButton();null!==r&&t.previousButton!==r&&(t.debugMessage(t,"monitor:  attaching click handler"),t.previousButton=r,r.addEventListener("click",function(r){try{t.enablePhantomClickCheck?(-1!=r.pointerId||t.handleEnterLikeClick)&&(t.debugMessage(t,"monitor:  captured click event"),e.handle_attempt(t)):(t.debugMessage(t,"monitor:  captured click event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},attachKeyHandler:function(e,t){if(t.enableKeyHandler)try{var r=t.findInputField();null!=r&&t.previousInputField!==r&&(t.debugMessage(t,"monitor:  attaching keyup handler"),t.previousInputField=r,r.addEventListener("keyup",function(r){try{t.debugMessage(t,"monitor:  captured keyup event - "+r),"Enter"===r.key&&(t.debugMessage(t,"monitor:  captured Enter key event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},monitor:function(){try{if(e.debugMessage(e,"monitor:  START"),!e.shouldScrapePage()){e.debugMessage(e,"monitor:  shouldScrapePage returned false - returning");return}e.debugMessage(e,"monitor:  shouldScrapePage returned true - continuing");var t=e.findButton();e.debugMessage(e,"button: "+t);var r=e.findInputField();e.debugMessage(e,"inputField: "+r);var n=this;if(!t||!r){e.debugMessage(e,"monitor:  could not find button and/or field - returning"),setTimeout(function(){try{n.monitor()}catch(e){usi_commons.report_error(e)}},1e3);return}setInterval(function(){try{n.attachClickHandler(n,e),n.attachKeyHandler(n,e)}catch(t){usi_commons.report_error(t)}},1e3)}catch(i){usi_commons.report_error(i)}},handle_attempt:function(e){try{var t=e.findInputField();if(!t){e.debugMessage(e,"handle_attempt:  did not find coupon code field - returning");return}var r=t.value.replaceAll(/[^\x00-\x7F]/ig,"");e.debugMessage(e,"handle_attempt:  scraped coupon code - "+r),r&&(this.code=r);var n=this;setTimeout(function(){try{n.scrape_success(n,e),n.scrape_error(n,e)}catch(t){usi_commons.report_error(t)}},e.scrapeDelay)}catch(i){usi_commons.report_error(i)}},scrape_success:function(e,t){try{if(t.debugMessage(t,"scrape_success:  START"),!e.code){t.debugMessage(t,"scrape_success:  no coupon code - returning");return}if(!t.isCouponValid()){t.debugMessage(t,"scrape_success:  coupon code not valid - returning");return}var r=t.scrapeDiscount();r=isNaN(r)?0:r,t.debugMessage(t,"scrape_success:  scraped discount - "+r);var n=t.scrapeSuccessMessage();t.debugMessage(t,"scrape_success:  scraped notes - "+n),usi_coupon.report_coupon_success(t.getCompanyId(),e.code,r,n)}catch(i){usi_commons.report_error(i)}},scrape_error:function(e,t){try{if(t.debugMessage(t,"scrape_error:  START"),!e.code){t.debugMessage(t,"scrape_error:  no coupon code - returning");return}if(!t.isCouponInvalid()){t.debugMessage(t,"scrape_error:  coupon code is valid - returning");return}usi_coupon.report_coupon_fail(t.getCompanyId(),e.code,t.scrapeFailedMessage())}catch(r){usi_commons.report_error(r)}}}},implMultiPage:function(e){return{code:"",discount:0,attachClickHandler:function(e,t){try{if(!t.enableClickHandler)return;var r=t.findButton();null!==r&&t.previousButton!==r&&(t.debugMessage(t,"monitor:  attaching click handler"),t.previousButton=r,r.addEventListener("click",function(r){try{t.enablePhantomClickCheck?(-1!=r.pointerId||t.handleEnterLikeClick)&&(t.debugMessage(t,"monitor:  captured click event"),e.handle_attempt(t)):(t.debugMessage(t,"monitor:  captured click event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},attachKeyHandler:function(e,t){try{if(!t.enableKeyHandler)return;var r=t.findInputField();null!=r&&t.previousInputField!==r&&(t.debugMessage(t,"monitor:  attaching keyup handler"),t.previousInputField=r,r.addEventListener("keyup",function(r){try{t.debugMessage(t,"monitor:  captured keyup event - "+r.key),"Enter"===r.key&&(t.debugMessage(t,"monitor:  captured Enter key event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},monitor:function(){try{if(e.debugMessage(e,"monitor multi-page:  START"),!e.shouldScrapePage()){e.debugMessage(e,"monitor multi-page:  shouldScrapePage returned false - returning");return}e.debugMessage(e,"monitor multi-page:  shouldScrapePage returned true - continuing");var t=e.findButton();e.debugMessage(e,"monitor multi-page: button: "+t);var r=e.findInputField();e.debugMessage(e,"monitor multi-page: inputField: "+r);var n=this;t&&r?setInterval(function(){try{n.attachClickHandler(n,e),n.attachKeyHandler(n,e)}catch(t){usi_commons.report_error(t)}},1e3):(e.debugMessage(e,"monitor:  could not find button and/or field - returning"),setTimeout(function(){try{n.monitor()}catch(e){usi_commons.report_error(e)}},1e3));var i=usi_cookies.get("usi_cm_attemptcode");if(i){this.code=i;var n=this;usi_cookies.del("usi_cm_attemptcode"),setTimeout(function(){n.scrape_success(n,e),n.scrape_error(n,e)},e.scrapeDelay)}}catch(o){usi_commons.report_error(o)}},handle_attempt:function(e){try{var t=e.findInputField();if(!t){e.debugMessage(e,"monitor multi-page: handle_attempt:  did not find coupon code field - returning");return}var r=t.value.replaceAll(/[^\x00-\x7F]/ig,"");e.debugMessage(e,"monitor multi-page: handle_attempt:  scraped coupon code - "+r),r&&(this.code=r),usi_cookies.set("usi_cm_attemptcode",r,usi_cookies.expire_time.hour,!0)}catch(n){usi_commons.report_error(n)}},scrape_success:function(e,t){try{if(t.debugMessage(t,"monitor multi-page: scrape_success:  START"),!e.code){t.debugMessage(t,"monitor multi-page: scrape_success:  no coupon code - returning");return}if(!t.isCouponValid()){t.debugMessage(t,"monitor multi-page: scrape_success:  coupon code not valid - returning");return}var r=t.scrapeDiscount();r=isNaN(r)?0:r,t.debugMessage(t,"monitor multi-page:  scrape_success:  scraped discount - "+r);var n=t.scrapeSuccessMessage();t.debugMessage(t,"monitor multi-page:  scrape_success:  scraped notes - "+n),usi_coupon.report_coupon_success(t.getCompanyId(),e.code,r,n)}catch(i){usi_commons.report_error(i)}},scrape_error:function(e,t){try{if(t.debugMessage(t,"monitor multi-page:  scrape_error:  START"),!e.code){t.debugMessage(t,"monitor multi-page:  scrape_error:  no coupon code - returning");return}if(!t.isCouponInvalid()){t.debugMessage(t,"monitor multi-page: scrape_error:  coupon code is valid - returning");return}usi_coupon.report_coupon_fail(t.getCompanyId(),e.code,t.scrapeFailedMessage())}catch(r){usi_commons.report_error(r)}}}}};n.label=t,e.push(n)}catch(i){usi_commons.report_error(i)}return this},setDebug:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].debug=!!t,this},setMultiPage:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].multiPage=!!t,this},setHandleEnterLikeClick:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].handleEnterLikeClick=!!t,this},enableClickHandler:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].enableClickHandler=!!t,this},enableKeyHandler:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].enableKeyHandler=!!t,this},setScrapeDelay:function(t){this.validateScrapersNotEmpty();var r=Number(t);return(isNaN(r)||r<0)&&(usi_commons.log("Invalid scrapeDelay - "+t),r=1500),e[e.length-1].scrapeDelay=r,this},shouldScrapePage:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].shouldScrapePage=t,this},findButton:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].findButton=t,this},findInputField:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].findInputField=t,this},scrapeDiscount:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].scrapeDiscount=t,this},isCouponInvalid:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].isCouponInvalid=t,this},scrapeFailedMessage:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].scrapeFailedMessage=t,this},isCouponValid:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].isCouponValid=t,this},scrapeSuccessMessage:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].scrapeSuccessMessage=t,this},setInitialWaitTime:function(e){if(void 0===e)throw"waitTimeMillis parameter is required";var r=Number(e);if(isNaN(r))throw"waitTimeMillis parameter must be a number";if(r<0)throw"waitTimeMillis must be >= 0";return t=r,this},setCompanyId:function(e){if(void 0===e)throw"id parameter is required";var t=Number(e);if(isNaN(t))throw"id parameter must be a number";if(t<=0)throw"id must be > 0";return r=t,this},recordUTMs:function(){for(var e="",t=["utm_source","utm_campaign","utm_medium","utm_term","utm_content"],r=0;r<t.length;r++)""!=usi_commons.gup(t[r])&&(""!=e&&(e+="&"),e+=t[r]+"="+usi_commons.gup(t[r]));""!=e&&usi_cookies.set("usi_coupon_utms",e,86400)},setEnablePhantomClickCheck:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].enablePhantomClickCheck=!!t,this},build:function(){return this.recordUTMs(),{monitor:function(){var n=function(){return 0};setTimeout(function(){try{for(var t=0;t<e.length;t++){var i=e[t];if(i.shouldScrapePage()){n=i.scrapeDiscount;break}}a.report(r,n)}catch(o){usi_commons.report_error(o)}try{for(var t=0;t<e.length;t++)e[t].multiPage?e[t].implMultiPage(e[t]).monitor():e[t].impl(e[t]).monitor()}catch(u){usi_commons.report_error(u)}},t)},autoApply:function(e,t){a.record(e,t)}}}}},proxy_builder:function(){var e=[],t=1e3,r=-1;return{validateScrapersNotEmpty:function(){if(0===e.length)throw"No scrapers defined"},addPage:function(t){if(void 0===t||!t)throw"Invalid label: "+t;try{var r={label:"default",debug:!1,previousButton:null,previousInputField:null,scrapeDelay:1500,multiPage:!1,handleEnterLikeClick:!1,enableKeyHandler:!0,enableClickHandler:!0,shouldScrapePage:function(){return!1},findButton:function(){return null},findInputField:function(){return null},isCouponInvalid:function(){return!1},handleCouponError:function(){},debugMessage:function(e,t){try{e.debug&&console.log("usi_coupon_proxy - "+e.label+": "+t)}catch(r){usi_commons.report_error_no_console(r)}},impl:function(e){return{code:"",discount:0,attachClickHandler:function(e,t){if(t.enableClickHandler)try{var r=t.findButton();null!==r&&t.previousButton!==r&&(t.debugMessage(t,"monitor:  attaching click handler"),t.previousButton=r,r.addEventListener("click",function(r){try{(-1!=r.pointerId||t.handleEnterLikeClick)&&(t.debugMessage(t,"monitor:  captured click event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},attachKeyHandler:function(e,t){if(t.enableKeyHandler)try{var r=t.findInputField();null!=r&&t.previousInputField!==r&&(t.debugMessage(t,"monitor:  attaching keyup handler"),t.previousInputField=r,r.addEventListener("keyup",function(r){try{t.debugMessage(t,"monitor:  captured keyup event - "+r),"Enter"===r.key&&(t.debugMessage(t,"monitor:  captured Enter key event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},monitor:function(){try{if(e.debugMessage(e,"monitor:  START"),!e.shouldScrapePage()){e.debugMessage(e,"monitor:  shouldScrapePage returned false - returning");return}e.debugMessage(e,"monitor:  shouldScrapePage returned true - continuing");var t=e.findButton();e.debugMessage(e,"button: "+t);var r=e.findInputField();e.debugMessage(e,"inputField: "+r);var n=this;if(!t||!r){e.debugMessage(e,"monitor:  could not find button and/or field - returning"),setTimeout(function(){try{n.monitor()}catch(e){usi_commons.report_error(e)}},1e3);return}setInterval(function(){try{n.attachClickHandler(n,e),n.attachKeyHandler(n,e)}catch(t){usi_commons.report_error(t)}},1e3)}catch(i){usi_commons.report_error(i)}},handle_attempt:function(e){try{var t=e.findInputField();if(!t){e.debugMessage(e,"handle_attempt:  did not find coupon code field - returning");return}var r=t.value.replaceAll(/[^\x00-\x7F]/ig,"");e.debugMessage(e,"handle_attempt:  scraped coupon code - "+r),r&&(this.code=r);var n=this;setTimeout(function(){try{n.scrape_error(n,e)}catch(t){usi_commons.report_error(t)}},e.scrapeDelay)}catch(i){usi_commons.report_error(i)}},scrape_error:function(e,t){try{if(t.debugMessage(t,"scrape_error:  START"),!e.code){t.debugMessage(t,"scrape_error:  no coupon code - returning");return}if(!t.isCouponInvalid()){t.debugMessage(t,"scrape_error:  coupon code is valid - returning");return}t.handleCouponError()}catch(r){usi_commons.report_error(r)}}}},implMultiPage:function(e){return{code:"",discount:0,attachClickHandler:function(e,t){try{if(!t.enableClickHandler)return;var r=t.findButton();null!==r&&t.previousButton!==r&&(t.debugMessage(t,"monitor:  attaching click handler"),t.previousButton=r,r.addEventListener("click",function(r){try{(-1!=r.pointerId||t.handleEnterLikeClick)&&(t.debugMessage(t,"monitor:  captured click event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},attachKeyHandler:function(e,t){try{if(!t.enableKeyHandler)return;var r=t.findInputField();null!=r&&t.previousInputField!==r&&(t.debugMessage(t,"monitor:  attaching keyup handler"),t.previousInputField=r,r.addEventListener("keyup",function(r){try{t.debugMessage(t,"monitor:  captured keyup event - "+r.key),"Enter"===r.key&&(t.debugMessage(t,"monitor:  captured Enter key event"),e.handle_attempt(t))}catch(n){usi_commons.report_error(n)}}))}catch(n){usi_commons.report_error(n)}},monitor:function(){try{if(e.debugMessage(e,"monitor multi-page:  START"),!e.shouldScrapePage()){e.debugMessage(e,"monitor multi-page:  shouldScrapePage returned false - returning");return}e.debugMessage(e,"monitor multi-page:  shouldScrapePage returned true - continuing");var t=e.findButton();e.debugMessage(e,"monitor multi-page: button: "+t);var r=e.findInputField();e.debugMessage(e,"monitor multi-page: inputField: "+r);var n=this;t&&r?setInterval(function(){try{n.attachClickHandler(n,e),n.attachKeyHandler(n,e)}catch(t){usi_commons.report_error(t)}},1e3):(e.debugMessage(e,"monitor:  could not find button and/or field - returning"),setTimeout(function(){try{n.monitor()}catch(e){usi_commons.report_error(e)}},1e3));var i=usi_cookies.get("usi_cp_attemptcode");if(i){this.code=i;var n=this;usi_cookies.del("usi_cp_attemptcode"),setTimeout(function(){n.scrape_error(n,e)},e.scrapeDelay)}}catch(o){usi_commons.report_error(o)}},handle_attempt:function(e){try{var t=e.findInputField();if(!t){e.debugMessage(e,"monitor multi-page: handle_attempt:  did not find coupon code field - returning");return}var r=t.value.replaceAll(/[^\x00-\x7F]/ig,"");e.debugMessage(e,"monitor multi-page: handle_attempt:  scraped coupon code - "+r),r&&(this.code=r),usi_cookies.set("usi_cp_attemptcode",r,usi_cookies.expire_time.hour,!0)}catch(n){usi_commons.report_error(n)}},scrape_error:function(e,t){try{if(t.debugMessage(t,"monitor multi-page:  scrape_error:  START"),!e.code){t.debugMessage(t,"monitor multi-page:  scrape_error:  no coupon code - returning");return}if(!t.isCouponInvalid()){t.debugMessage(t,"monitor multi-page: scrape_error:  coupon code is valid - returning");return}t.handleCouponError()}catch(r){usi_commons.report_error(r)}}}}};r.label=t,e.push(r)}catch(n){usi_commons.report_error(n)}return this},setDebug:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].debug=!!t,this},setMultiPage:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].multiPage=!!t,this},setHandleEnterLikeClick:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].handleEnterLikeClick=!!t,this},enableClickHandler:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].enableClickHandler=!!t,this},enableKeyHandler:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].enableKeyHandler=!!t,this},setScrapeDelay:function(t){this.validateScrapersNotEmpty();var r=Number(t);return(isNaN(r)||r<0)&&(usi_commons.log("Invalid scrapeDelay - "+t),r=1500),e[e.length-1].scrapeDelay=r,this},shouldScrapePage:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].shouldScrapePage=t,this},findButton:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].findButton=t,this},findInputField:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].findInputField=t,this},isCouponInvalid:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].isCouponInvalid=t,this},handleCouponError:function(t){return this.validateScrapersNotEmpty(),e[e.length-1].handleCouponError=t,this},setInitialWaitTime:function(e){if(void 0===e)throw"waitTimeMillis parameter is required";var r=Number(e);if(isNaN(r))throw"waitTimeMillis parameter must be a number";if(r<0)throw"waitTimeMillis must be >= 0";return t=r,this},setCompanyId:function(e){if(void 0===e)throw"id parameter is required";var t=Number(e);if(isNaN(t))throw"id parameter must be a number";if(t<=0)throw"id must be > 0";return r=t,this},build:function(){return{monitor:function(){for(var n=function(){return 0},i=0;i<e.length;i++){var o=e[i];if(o.shouldScrapePage()){n=o.scrapeDiscount;break}}a.report(r,n),setTimeout(function(){try{for(var t=0;t<e.length;t++)e[t].multiPage?e[t].implMultiPage(e[t]).monitor():e[t].impl(e[t]).monitor()}catch(r){usi_commons.report_error(r)}},t)},autoApply:function(e,t){a.record(e,t)}}}}}}}());

if (typeof usi_app === 'undefined') {
	try {
		if("undefined"==typeof usi_cookies){if(usi_cookies={expire_time:{minute:60,hour:3600,two_hours:7200,four_hours:14400,day:86400,week:604800,two_weeks:1209600,month:2592e3,year:31536e3,never:31536e4},max_cookies_count:15,max_cookie_length:1e3,update_window_name:function(e,i,n){try{var t=-1;if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t=r.getTime()}var o=window.top||window,l=0;null!=i&&-1!=i.indexOf("=")&&(i=i.replace(RegExp("=","g"),"USIEQLS")),null!=i&&-1!=i.indexOf(";")&&(i=i.replace(RegExp(";","g"),"USIPRNS"));for(var a=o.name.split(";"),u="",f=0;f<a.length;f++){var c=a[f].split("=");3==c.length?(c[0]==e&&(c[1]=i,c[2]=t,l=1),null!=c[1]&&"null"!=c[1]&&(u+=c[0]+"="+c[1]+"="+c[2]+";")):""!=a[f]&&(u+=a[f]+";")}0==l&&(u+=e+"="+i+"="+t+";"),o.name=u}catch(s){}},flush_window_name:function(e){try{for(var i=window.top||window,n=i.name.split(";"),t="",r=0;r<n.length;r++){var o=n[r].split("=");3==o.length&&(0==o[0].indexOf(e)||(t+=n[r]+";"))}i.name=t}catch(l){}},get_from_window_name:function(e){try{for(var i,n,t=(window.top||window).name.split(";"),r=0;r<t.length;r++){var o=t[r].split("=");if(3==o.length){if(o[0]==e&&(n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),!("-1"!=o[2]&&0>usi_cookies.datediff(o[2]))))return i=[n,o[2]]}else if(2==o.length&&o[0]==e)return n=o[1],-1!=n.indexOf("USIEQLS")&&(n=n.replace(/USIEQLS/g,"=")),-1!=n.indexOf("USIPRNS")&&(n=n.replace(/USIPRNS/g,";")),i=[n,new Date().getTime()+6048e5]}}catch(l){}return null},datediff:function(e){return e-new Date().getTime()},count_cookies:function(e){return e=e||"usi_",usi_cookies.search_cookies(e).length},root_domain:function(){try{var e=document.domain.split("."),i=e[e.length-1];if("com"==i||"net"==i||"org"==i||"us"==i||"co"==i||"ca"==i)return e[e.length-2]+"."+e[e.length-1]}catch(n){}return document.domain},create_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+encodeURIComponent(i)+t+"; path=/;domain="+l+"; "+o}},create_nonencoded_cookie:function(e,i,n){if(!1!==navigator.cookieEnabled){var t="";if(-1!=n){var r=new Date;r.setTime(r.getTime()+1e3*n),t="; expires="+r.toGMTString()}var o="samesite=none;";0==location.href.indexOf("https://")&&(o+="secure;");var l=usi_cookies.root_domain();"undefined"!=typeof usi_parent_domain&&-1!=document.domain.indexOf(usi_parent_domain)&&(l=usi_parent_domain),document.cookie=e+"="+i+t+"; path=/;domain="+l+"; "+o}},read_cookie:function(e){if(!1===navigator.cookieEnabled)return null;var i=e+"=",n=[];try{n=document.cookie.split(";")}catch(t){}for(var r=0;r<n.length;r++){for(var o=n[r];" "==o.charAt(0);)o=o.substring(1,o.length);if(0==o.indexOf(i))return decodeURIComponent(o.substring(i.length,o.length))}return null},del:function(e){usi_cookies.set(e,null,-100);try{null!=localStorage&&localStorage.removeItem(e),null!=sessionStorage&&sessionStorage.removeItem(e)}catch(i){}},get_ls:function(e){try{var i=localStorage.getItem(e);if(null!=i){if(0==i.indexOf("{")&&-1!=i.indexOf("usi_expires")){var n=JSON.parse(i);if(new Date().getTime()>n.usi_expires)return localStorage.removeItem(e),null;i=n.value}return decodeURIComponent(i)}}catch(t){}return null},get:function(e){var i=usi_cookies.read_cookie(e);if(null!=i)return i;try{if(null!=localStorage&&(i=usi_cookies.get_ls(e),null!=i))return i;if(null!=sessionStorage&&(i=sessionStorage.getItem(e),null!=i))return decodeURIComponent(i)}catch(n){}var t=usi_cookies.get_from_window_name(e);if(null!=t&&t.length>1)try{i=decodeURIComponent(t[0])}catch(r){return t[0]}return i},get_json:function(e){var i=null,n=usi_cookies.get(e);if(null==n)return null;try{i=JSON.parse(n)}catch(t){n=n.replace(/\\"/g,'"');try{i=JSON.parse(JSON.parse(n))}catch(r){try{i=JSON.parse(n)}catch(o){}}}return i},search_cookies:function(e){e=e||"";var i=[];return document.cookie.split(";").forEach(function(n){var t=n.split("=")[0].trim();(""===e||0===t.indexOf(e))&&i.push(t)}),i},set:function(e,i,n,t){"undefined"!=typeof usi_nevercookie&&!0==usi_nevercookie&&(t=!1),void 0===n&&(n=-1);try{i=i.replace(/(\r\n|\n|\r)/gm,"")}catch(r){}"undefined"==typeof usi_windownameless&&usi_cookies.update_window_name(e+"",i+"",n);try{if(n>0&&null!=localStorage){var o=new Date,l={value:i,usi_expires:o.getTime()+1e3*n};localStorage.setItem(e,JSON.stringify(l))}else null!=sessionStorage&&sessionStorage.setItem(e,i)}catch(a){}if(t||null==i){if(null!=i){if(null==usi_cookies.read_cookie(e)&&!t&&usi_cookies.search_cookies("usi_").length+1>usi_cookies.max_cookies_count){usi_cookies.report_error('Set cookie "'+e+'" failed. Max cookies count is '+usi_cookies.max_cookies_count);return}if(i.length>usi_cookies.max_cookie_length){usi_cookies.report_error('Cookie "'+e+'" truncated ('+i.length+"). Max single-cookie length is "+usi_cookies.max_cookie_length);return}}usi_cookies.create_cookie(e,i,n)}},set_json:function(e,i,n,t){var r=JSON.stringify(i).replace(/^"/,"").replace(/"$/,"");usi_cookies.set(e,r,n,t)},flush:function(e){e=e||"usi_";var i,n,t,r=document.cookie.split(";");for(i=0;i<r.length;i++)0==(n=r[i]).trim().toLowerCase().indexOf(e)&&(t=n.trim().split("=")[0],usi_cookies.del(t));usi_cookies.flush_window_name(e);try{if(null!=localStorage)for(var o in localStorage)0==o.indexOf(e)&&localStorage.removeItem(o);if(null!=sessionStorage)for(var o in sessionStorage)0==o.indexOf(e)&&sessionStorage.removeItem(o)}catch(l){}},print:function(){for(var e=document.cookie.split(";"),i="",n=0;n<e.length;n++){var t=e[n];0==t.trim().toLowerCase().indexOf("usi_")&&(console.log(decodeURIComponent(t.trim())+" (cookie)"),i+=","+t.trim().toLowerCase().split("=")[0]+",")}try{if(null!=localStorage)for(var r in localStorage)0==r.indexOf("usi_")&&"string"==typeof localStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+usi_cookies.get_ls(r)+" (localStorage)"),i+=","+r+",");if(null!=sessionStorage)for(var r in sessionStorage)0==r.indexOf("usi_")&&"string"==typeof sessionStorage[r]&&-1==i.indexOf(","+r+",")&&(console.log(r+"="+sessionStorage[r]+" (sessionStorage)"),i+=","+r+",")}catch(o){}for(var l=(window.top||window).name.split(";"),a=0;a<l.length;a++){var u=l[a].split("=");if(3==u.length&&0==u[0].indexOf("usi_")&&-1==i.indexOf(","+u[0]+",")){var f=u[1];-1!=f.indexOf("USIEQLS")&&(f=f.replace(/USIEQLS/g,"=")),-1!=f.indexOf("USIPRNS")&&(f=f.replace(/USIPRNS/g,";")),console.log(u[0]+"="+f+" (window.name)"),i+=","+t.trim().toLowerCase().split("=")[0]+","}}},value_exists:function(){var e,i;for(e=0;e<arguments.length;e++)if(i=usi_cookies.get(arguments[e]),""===i||null===i||"null"===i||"undefined"===i)return!1;return!0},report_error:function(e){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(e)}},"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.gup&&"function"==typeof usi_commons.gup_or_get_cookie)try{""!=usi_commons.gup("usi_email_id")?usi_cookies.set("usi_email_id",usi_commons.gup("usi_email_id").split(".")[0],Number(usi_commons.gup("usi_email_id").split(".")[1]),!0):null==usi_cookies.read_cookie("usi_email_id")&&null!=usi_cookies.get_from_window_name("usi_email_id")&&(usi_commons.load_script("https://www.upsellit.com/launch/blank.jsp?usi_email_id_fix="+encodeURIComponent(usi_cookies.get_from_window_name("usi_email_id")[0])),usi_cookies.set("usi_email_id",usi_cookies.get_from_window_name("usi_email_id")[0],(usi_cookies.get_from_window_name("usi_email_id")[1]-new Date().getTime())/1e3,!0)),""!=usi_commons.gup_or_get_cookie("usi_debug")&&(usi_commons.debug=!0),""!=usi_commons.gup_or_get_cookie("usi_qa")&&(usi_commons.domain=usi_commons.cdn="https://prod.upsellit.com")}catch(e){usi_commons.report_error(e)}-1!=location.href.indexOf("usi_clearcookies")&&usi_cookies.flush()}
"undefined"==typeof usi_date&&((usi_date={}).add_hours=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+36e5*t)},usi_date.add_minutes=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+6e4*t)},usi_date.add_seconds=function(e,t){return!1===usi_date.is_date(e)?e:new Date(e.getTime()+1e3*t)},usi_date.is_date=function(e){return null!=e&&"object"==typeof e&&e instanceof Date==!0&&!1===isNaN(e.getTime())},usi_date.is_after=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),r=new Date(e);return t.getTime()>r.getTime()}catch(s){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(s)}return!1},usi_date.is_before=function(e){try{usi_date.check_format(e);var t=usi_date.set_date(),r=new Date(e);return t.getTime()<r.getTime()}catch(s){"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error(s)}return!1},usi_date.is_between=function(e,t){return usi_date.check_format(e,t),usi_date.is_after(e)&&usi_date.is_before(t)},usi_date.check_format=function(e,t){(-1!=e.indexOf(" ")||t&&-1!=t.indexOf(" "))&&"undefined"!=typeof usi_commons&&"function"==typeof usi_commons.report_error&&usi_commons.report_error("Incorrect format: Use YYYY-MM-DDThh:mm:ss")},usi_date.string_to_date=function(e,t){t=t||!1;var r=null,s=/^[0-2]?[0-9]\/[0-3]?[0-9]\/\d{4}(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e),n=/^(\d{4}\-[0-2]?[0-9]\-[0-3]?[0-9])(\s[0-2]?[0-9]\:[0-5]?[0-9](?:\:[0-5]?[0-9])?)?$/.exec(e);if(2===(s||[]).length){if(r=new Date(e),""===(s[1]||"")&&!0===t){var a=new Date;r=usi_date.add_hours(r,a.getHours()),r=usi_date.add_minutes(r,a.getMinutes()),r=usi_date.add_seconds(r,a.getSeconds())}}else if(3===(n||[]).length){var c=n[1].split(/\-/g),i=c[1]+"/"+c[2]+"/"+c[0];return i+=n[2]||"",usi_date.string_to_date(i,t)}return r},usi_date.set_date=function(){var e=new Date,t=usi_commons.gup("usi_force_date");if(""!==t){t=decodeURIComponent(t);var r=usi_date.string_to_date(t,!0);null!=r?(e=r,usi_cookies.set("usi_force_date",t,usi_cookies.expire_time.hour),usi_commons.log("Date forced to: "+e)):usi_cookies.del("usi_force_date")}else e=null!=usi_cookies.get("usi_force_date")?usi_date.string_to_date(usi_cookies.get("usi_force_date"),!0):new Date;return e},usi_date.diff=function(e,t,r,s){null==s&&(s=1),""!=(r||"")&&(r=usi_date.get_units(r));var n=null;if(!0===usi_date.is_date(t)&&!0===usi_date.is_date(e))try{var a=Math.abs(t-e);switch(r){case"ms":n=a;break;case"seconds":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3),s);break;case"minutes":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60),s);break;case"hours":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60)/parseFloat(60),s);break;case"days":n=usi_dom.to_decimal_places(parseFloat(a)/parseFloat(1e3)/parseFloat(60)/parseFloat(60)/parseFloat(24),s)}}catch(c){n=null}return n},usi_date.get_units=function(e){var t="";switch(e.toLowerCase()){case"days":case"day":case"d":t="days";break;case"hours":case"hour":case"hrs":case"hr":case"h":t="hours";break;case"minutes":case"minute":case"mins":case"min":case"m":t="minutes";break;case"seconds":case"second":case"secs":case"sec":case"s":t="seconds";break;case"ms":case"milliseconds":case"millisecond":case"millis":case"milli":t="ms"}return t});
if (typeof usi_aff === 'undefined') {
	usi_aff = {

		fix_linkshare: function() {
			try {
				if (usi_commons.gup("ranSiteID") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var now = new Date();
						var date = now.getUTCFullYear() + ((now.getUTCMonth() + 1 < 10 ? "0" : "") + (now.getUTCMonth() + 1)) + ((now.getUTCDate() < 10 ? "0" : "") + now.getDate());
						var time = (now.getUTCHours() < 10 ? "0" : "") + now.getUTCHours() + ((now.getUTCMinutes() < 10 ? "0" : "") + now.getUTCMinutes());
						usi_cookies.create_nonencoded_cookie("usi_rmStore", "ald:" + date + "_" + time + "|atrv:" + usi_commons.gup("ranSiteID"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_rmStore") != null) {
					usi_cookies.create_nonencoded_cookie("rmStore", usi_cookies.read_cookie("usi_rmStore"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_cj: function() {
			try {
				if (usi_commons.gup("cjevent") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_cjevent", usi_commons.gup("cjevent"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_cjevent") != null) {
					usi_cookies.create_nonencoded_cookie("cjevent", usi_cookies.read_cookie("usi_cjevent"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_sas: function() {
			try {
				if (usi_commons.gup("sscid") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_sscid", usi_commons.gup("sscid"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_sscid") != null) {
					usi_cookies.create_nonencoded_cookie("sas_m_awin", "{\"clickId\":\"" + usi_cookies.read_cookie("usi_sscid")+ "\"}", usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_awin: function(id) {
			try {
				if (usi_commons.gup("awc") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_awc", usi_commons.gup("awc"), usi_cookies.expire_time.month);
						usi_cookies.del("_aw_j_"+id);
					}
				}
				if (usi_cookies.read_cookie("usi_awc") != null) {
					usi_cookies.create_nonencoded_cookie("_aw_m_"+id, usi_cookies.read_cookie("usi_awc"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_pj: function() {
			try {
				if (usi_commons.gup("clickId") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var now = new Date();
						var usi_days = Math.floor(now / 8.64e7);
						usi_cookies.create_nonencoded_cookie('usi-pjn-click', '[{"id":"' + usi_commons.gup("clickId") + '","days":' + usi_days + ',"type":"p"}]', usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi-pjn-click") != null) {
					usi_cookies.create_nonencoded_cookie("pjn-click", usi_cookies.read_cookie("usi-pjn-click"), usi_cookies.expire_time.month);
					localStorage.setItem("pjnClickData", usi_cookies.read_cookie("usi-pjn-click"));
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_ir: function(id) {
			try {
				if (usi_commons.gup("irclickid") != "" || usi_commons.gup("clickid") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						var usi_click = usi_commons.gup("irclickid");
						if (usi_click == "") {
							usi_click = usi_commons.gup("clickid");
						}
						var date_now = Date.now().toString();
						var cookie_value = date_now + "|-1|" + date_now + "|" + usi_click + "|";
						usi_cookies.create_nonencoded_cookie("usi_IR_" + id, cookie_value, usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_IR_" + id) != null) {
					usi_cookies.create_nonencoded_cookie("IR_" + id, usi_cookies.read_cookie("usi_IR_" + id), usi_cookies.expire_time.month);
					usi_cookies.create_nonencoded_cookie("irclickid", usi_cookies.read_cookie("usi_IR_" + id).split("|")[3], usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},

		fix_cf: function() {
			try {
				if (usi_commons.gup("cfclick") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi-cfjump-click", usi_commons.gup("cfclick"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi-cfjump-click") != null) {
					usi_cookies.create_nonencoded_cookie("cfjump-click", usi_cookies.read_cookie("usi-cfjump-click"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		fix_avantlink:function() {
			try {
				if (usi_commons.gup("avad") != "") {
					usi_aff.log_url();
					if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
						usi_cookies.del("usi_clicked_1");
						usi_cookies.create_nonencoded_cookie("usi_avad", usi_commons.gup("avad"), usi_cookies.expire_time.month);
					}
				}
				if (usi_cookies.read_cookie("usi_avad") != null) {
					usi_cookies.create_nonencoded_cookie("avmws", usi_cookies.read_cookie("usi_avad"), usi_cookies.expire_time.month);
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		get_impact_pixel: function () {
			var pixel = "";
			try {
				var scripts = document.getElementsByTagName("script");
				for (var i = 0; i < scripts.length; i++) {
					var text = scripts[i].innerText;
					if (text && (text.indexOf("ire('trackConversion'") != -1 || text.indexOf('ire("trackConversion"') != -1)) {
						pixel = text.trim().replace(/\s/g, '')
						pixel = pixel.split("trackConversion")[1];
						pixel = pixel.split("});")[0];
						return pixel;
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return pixel;
		},
		log_url: function() {
			usi_aff.load_script("https://www.upsellit.com/launch/blank.jsp?aff_click=" + encodeURIComponent(location.href));
		},
		monitor_affiliate_pixel: function (callback) {
			try {
				var pixels = usi_aff.report_affiliate_pixels();
				if (pixels) {
					if (typeof callback === "function") callback(pixels);
					return usi_aff.parse_pixels(pixels);
				}
				setTimeout(function () {
					usi_aff.monitor_affiliate_pixel(callback);
				}, 1000);
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		parse_pixels: function(pixels){
			try {
				usi_aff.load_script("https://www.upsellit.com/launch/blank.jsp?pixel_found=" + encodeURIComponent(location.href) +"&"+pixels);
			} catch (err) {
				usi_commons.report_error(err);
			}
		},
		report_affiliate_pixels: function () {
			var params = '';
			try {
				var pixels = {
					cj: document.querySelector("[src*='emjcd.com']"),
					sas: document.querySelector("[src*='shareasale.com/sale.cfm']"),
					linkshare: document.querySelector("[src*='track.linksynergy.com']"),
					pj: document.querySelector("[src*='t.pepperjamnetwork.com/track']"),
					avant: document.querySelector("[src*='tracking.avantlink.com/ptcfp.php']"),
					ir: { src: usi_aff.get_impact_pixel() },
					awin1: document.querySelector("[src*='awin1.com/sread.js']"),
					awin2: document.querySelector("[src*='zenaps.com/sread.js']"),
					cf: document.querySelector("[src*='https://cfjump.'][src*='.com/track']"),
					saasler1: document.querySelector("[src*='engine.saasler.com']"),
					saasler2: document.querySelector("[src*='saasler-impact.herokuapp.com']")
				};
				for (var i in pixels) {
					if (pixels[i] && pixels[i].src) {
						params += '&' + i + '=' + encodeURIComponent(pixels[i].src);
					}
				}
			} catch (err) {
				usi_commons.report_error(err);
			}
			return params;
		},
		load_script: function(source) {
			try {
				var docHead = document.getElementsByTagName("head")[0];
				var newScript = document.createElement('script');
				newScript.type = 'text/javascript';
				newScript.src = source;
				docHead.appendChild(newScript);
			} catch(err) {
				usi_commons.report_error(err);
			}
		}
	}
}


		usi_app = {};
		usi_app.main = function () {
			try {
				usi_app.company_id = '11543';
				usi_app.force_date = usi_commons.gup_or_get_cookie('usi_force_date');
				usi_app.recommendation_site_product = "47347";
				usi_app.url = location.href.toLowerCase();
				usi_app.product = {};
				usi_app.force_date = usi_commons.gup_or_get_cookie('usi_force_date');
				usi_app.is_product_page = usi_app.url.match("/products/") != null;
				usi_app.is_checkout_page = usi_app.url.match("/checkouts/") != null;
				usi_app.is_confirmation_page = usi_app.url.match("thank_you") != null;

				// Booleans
				usi_app.is_enabled = usi_commons.gup_or_get_cookie("usi_enable", usi_cookies.expire_time.hour, true) != "";
				usi_app.is_forced = usi_commons.gup_or_get_cookie("usi_force", usi_cookies.expire_time.hour, true) != "";
				usi_app.is_suppressed = !usi_app.is_forced && (usi_app.url.match("kickscrew.com") == null ||
					usi_app.is_confirmation_page ||
					usi_cookies.value_exists("usi_sale"));

				// Suppress on 404 pages
				if (document.title.indexOf('404') != -1) return;

				usi_app.cms_client = usi_coupon.client_builder()
						.setCompanyId(11543)
						.addPage('checkout')
						.setScrapeDelay(2500)
						.shouldScrapePage(function () {
							return usi_app.is_checkout_page;
						})
						.findButton(function() {
							return document.getElementById(" ");
						})
						.findInputField(function() {
							return document.getElementById('TextField8');
						})
						.scrapeDiscount(function() {
							var discountedPriceText = document.getElementsByClassName("_19gi7yt0 _19gi7ytl _1fragemfs _19gi7yt1 notranslate")[0].innerText;
							var discountLocation = document.getElementsByClassName("_19gi7yt0 _19gi7yth _1fragemfq _19gi7ytb");
							var discountText = "0";
							if (discountLocation !== null) {
								var disLength = discountLocation.length;
								if (disLength != 0) {
									discountText = document.getElementsByClassName("_19gi7yt0 _19gi7yth _1fragemfq _19gi7ytb")[disLength-1];
								} else {
									return 0;
								}
							} else {
								return 0;
							}

							var currencyDisIndex = discountedPriceText.indexOf("$");
							if (currencyDisIndex === -1) {
								return 0;
							}

							var discount = parseFloat(discountText.substring(currencyDisIndex + 1));
							return isNaN(discount) ? 0 : discount;
						})
						.isCouponInvalid(function() {
							var errorMsgElement = document.getElementById('error-for-reduction_code');
							if (!errorMsgElement || !errorMsgElement.innerText) {
								return false;
							}

							return getComputedStyle(errorMsgElement).display !== 'none';


						})
						.scrapeFailedMessage(function() {
							var errorMsgElement = document.getElementById('error-for-reduction_code');
							if (!errorMsgElement || !errorMsgElement.innerText) {
								return '';
							}

							if (getComputedStyle(errorMsgElement).display === 'none') {
								return '';
							}

							return errorMsgElement.innerText;
						})
						.isCouponValid(function() {
							var successMsgElements = document.querySelectorAll('span.reduction-code__text');
							if (!successMsgElements) {
								return false;
							}

							var successMsgs = [];
							for (var i = 0; i < successMsgElements.length; i++) {
								var innerText = successMsgElements[i].innerText;
								if (innerText) {
									successMsgs.push(innerText.trim());
								}
							}

							return successMsgs.length !== 0;
						})
						.scrapeSuccessMessage(function() {
							var successMsgElements = document.querySelectorAll('span.reduction-code__text');
							if (!successMsgElements) {
								return '';
							}

							var successMsgs = [];
							for (var i = 0; i < successMsgElements.length; i++) {
								var innerText = successMsgElements[i].innerText;
								if (innerText) {
									successMsgs.push(innerText.trim());
								}
							}

							if (successMsgs.length === 0) {
								return '';
							}

							return JSON.stringify(successMsgs);
						})
						.build();
				usi_app.cms_client.monitor();

				try {
					if (usi_commons.gup("irclickid") != "" || usi_commons.gup("clickid") != "") {
						usi_aff.log_url();
						if (location.href.indexOf("usi_email_id") != -1 || usi_cookies.get("usi_clicked_1") != null) {
							usi_cookies.del("usi_clicked_1");
							var usi_click = usi_commons.gup("irclickid");
							if (usi_click == "") {
								usi_click = usi_commons.gup("clickid");
							}
							var date_now = Date.now().toString();
							var cookie_value = date_now + "|-1|" + date_now + "|" + usi_click + "|";
							usi_cookies.create_nonencoded_cookie("usi_IR_" + "12943", cookie_value, usi_cookies.expire_time.month);
						}
					}
					if (usi_cookies.read_cookie("usi_IR_" + "12943") != null) {
						usi_cookies.create_nonencoded_cookie("IR_" + "12943", usi_cookies.read_cookie("usi_IR_" + "12943"), usi_cookies.expire_time.month);
						usi_cookies.create_nonencoded_cookie("irclickid", usi_cookies.read_cookie("usi_IR_" + "12943").split("|")[3], usi_cookies.expire_time.month);
					}
				} catch (err) {
					usi_commons.report_error(err);
				}

				usi_aff.monitor_affiliate_pixel(function(){
					if (typeof USI_orderID == "undefined") {
						usi_commons.load_script("//www.upsellit.com/active/kickscrew_pixel.jsp");
					}
				});

				// Collect product page data
				if (usi_app.is_product_page) {
					usi_cookies.set("usi_pdp_visited", "1", usi_cookies.expire_time.week);

					usi_app.product = usi_app.scrape_product_page();

					var real_time = usi_app.product.extra && usi_app.product.extra.indexOf('OUTOFSTOCK') !== -1;
					usi_commons.send_prod_rec(usi_app.recommendation_site_product, usi_app.product, real_time);
					usi_commons.log(usi_app.product);
				}

				if (usi_app.is_checkout_page) {
					usi_app.product = usi_app.scrape_checkout_page();
				}

				if (usi_app.is_suppressed) {
					return usi_commons.log("usi_app.main is suppressed");
				}
				// Load campaigns
				usi_app.load();
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load = function () {
			try {
				usi_commons.log("usi_app.load()");

				if (typeof usi_js !== 'undefined' && typeof usi_js.cleanup === 'function') {
					usi_js.cleanup();
				}
				if (usi_app.is_suppressed) {
					return usi_commons.log("usi_app.load is suppressed");
				}

				if (usi_cookies.value_exists("usi_pdp_visited") || usi_app.is_checkout_page) {
					if (usi_date.is_between('2023-12-18T00:01:00-08:00', '2023-12-25T23:59:00-08:00')) {
						// Holiday Sale TT
						usi_commons.load_view("sGIEaCcldBaLnu5XVAfy1xk", "47519", usi_commons.device + "_holiday");
					} else {
						// Social Proof TT
						var usi_pid = usi_cookies.value_exists("usi_prod_pid_1") ? usi_cookies.get("usi_prod_pid_1") : usi_app.product.pid;
						usi_app.load_social_proof(usi_pid, function () {
							if (usi_app.product_data) {
								usi_commons.log(usi_app.product_data);
								usi_commons.load_view("sGIEaCcldBaLnu5XVAfy1xk", "47519", usi_commons.device);
							}
						});
					}
				}
			} catch(err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.load_social_proof = function(pid, callback){
			try {
				usi_app.grab_sales = function(product_data){
					try {
						usi_app.views_data = product_data;
						usi_commons.load_script(usi_commons.cdn + "/utility/pid_lookup.jsp?pid=" + pid +
							"&days_back=30&orderID=" + usi_app.recommendation_site_cart +
							"&viewID=" + usi_app.recommendation_site_product +
							"&companyID=" + usi_app.company_id +
							"&custom_callback=usi_app.social_proof_callback");
					} catch (err) {
						usi_commons.report_error(err);
					}
				};
				usi_app.social_proof_callback = function(product_data){
					try {
						usi_commons.log(product_data);
						callback(product_data);
					} catch (err) {
						usi_commons.report_error(err);
					}
				};
				usi_commons.load_script(usi_commons.cdn + "/utility/pid_lookup.jsp?pid=" + pid +
					"&days_back=14&orderID=" + usi_app.recommendation_site_cart +
					"&viewID=" + usi_app.recommendation_site_product +
					"&companyID=" + usi_app.company_id +
					"&custom_callback=usi_app.grab_sales");
			} catch (err) {
				usi_commons.report_error(err);
			}
		}

		usi_app.scrape_product_page = function() {
			usi_commons.log("usi_app.scrape_product_page()");
			try {
				var product = {};
				var prop;
				product.link = location.protocol + '//' + location.host + location.pathname;
				product.pid = product.link.substring(product.link.lastIndexOf("/") + 1).split("-").slice(-2).join("-");
				product.image = document.querySelector('meta[property="og:image"]').content;
				product.name = document.querySelector('meta[property="og:title"]').content;
				if (document.querySelector('#add_to_cart .price-area .current-price.theme-money') != null) {
					product.price = document.querySelector('#add_to_cart .price-area .current-price.theme-money').textContent;
				}
				product.in_stock = document.querySelector("#add_to_cart") !== null && document.querySelector("#add_to_cart").textContent.match(/checkout/i) != null;
				product.extra = JSON.stringify({
					stock: product.in_stock ? "INSTOCK" : "OUTOFSTOCK"
				});



				for (prop in product) {
					if (product.hasOwnProperty(prop)) {
						usi_cookies.set("usi_prod_" + prop + "_1", product[prop], usi_cookies.expire_time.week);
					}
				}
				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.scrape_checkout_page = function() {
			usi_commons.log("usi_app.scrape_checkout_page()");
			try {
				var product = {};
				var prop;
				product.image = document.querySelector(".product").querySelector(".product__image img").src;
				product.name = document.querySelector(".product").querySelector(".product__description__name").textContent.trim();
				product.price = document.querySelector(".product").querySelector(".product__price").textContent.trim();

				for (prop in product) {
					if (product.hasOwnProperty(prop)) {
						usi_cookies.set("usi_prod_" + prop + "_1", product[prop], usi_cookies.expire_time.week);
					}
				}

				return product;
			} catch (err) {
				usi_commons.report_error(err);
			}
		};

		usi_app.check_for_change = function(){
			if (usi_app.current_page == undefined || usi_app.current_page != location.href) {
				usi_app.current_page = location.href;
				usi_app.main();
				usi_commons.log("USI: running main");
			}
			setTimeout(usi_app.check_for_change, 1000);
		};
		if (!usi_app.check_for_change_timeout_id) {
			usi_app.check_for_change_timeout_id = setTimeout(usi_app.check_for_change, 1000);
		}
	} catch(err) {
		usi_commons.report_error(err);
	}
}