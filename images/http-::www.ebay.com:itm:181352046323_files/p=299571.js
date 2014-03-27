var ADGEAR=ADGEAR||{};ADGEAR.lang=ADGEAR.lang||{};
ADGEAR.lang.namespace=function(b){var a=b.split(".");
var d=window;for(var c=0;c<a.length;c++){d[a[c]]=d[a[c]]||{};
d=d[a[c]]}return d};ADGEAR.lang.singleton=function(){var d=Array.prototype.slice.call(arguments);
var c=d.shift();var g=d.shift();var b=c.split(".");
var h=window;var a=b.length-1;var f;for(var e=0;
e<a;e++){h[b[e]]=h[b[e]]||{};h=h[b[e]]}f=h[b[a]];
h[b[a]]=f||g.apply(null,d);return h};ADGEAR.lang.klass=function(a,b){return ADGEAR.lang.singleton(a,function(){return b
})};ADGEAR.lang.bind=function(b,c){var a=c;
return function(){return b.apply(a,arguments)
}};ADGEAR.lang.mergeHashes=function(c,a){var d={};
for(var b in c){d[b]=c[b]}for(var b in a){d[b]=a[b]
}return d};ADGEAR.lang.log=function(c){if((typeof ADGEAR_JS_DEBUG==="undefined")||(ADGEAR_JS_DEBUG!==true)){return
}try{if(typeof(window.console)==="object"){window.console.log(c)
}var g=document.getElementById("adgearPreviewConsole");
if(g){var f=g.getElementsByTagName("ul");
if(f&&f[0]){f=f[0]}else{f=document.createElement("ul");
g.appendChild(f)}var a=new Date();var b=document.createElement("li");
b.innerHTML="<strong>[ "+String(a.getFullYear())+"-"+String(a.getMonth()+1)+"-"+String(a.getDate())+" "+String(a.getHours())+":"+String(a.getMinutes())+":"+String(a.getSeconds())+"  ] &gt;&gt; </strong>"+String(c);
f.appendChild(b);g.scrollTop=g.scrollHeight
}}catch(d){}};ADGEAR.lang.indexOf=function(d,b){var a=d.length;
var c=Number(arguments[2])||0;c=(c<0)?Math.ceil(c):Math.floor(c);
if(c<0){c+=a}for(;(c>=0)&&(c<a);c++){if(d[c]===b){return c
}}return -1};ADGEAR.lang.safeDecodeURIComponent=function(c){var a="";
try{a=decodeURIComponent(c)}catch(b){}return a
};ADGEAR.lang.klass("ADGEAR.EventQueue",function(){var h={num_processed:0,num_loaded:0,num_error:0,num_aborted:0};
var f=new Array();var b=new Image();var j=false;
function i(){h.num_processed+=1;b=new Image();
if(f.length>0){d()}else{j=false}}function e(){h.num_loaded+=1;
i()}function c(){h.num_error+=1;i()}function a(){h.num_aborted+=1;
i()}function d(){j=true;b.onload=e;b.onerror=c;
b.onabort=a;b.src=f.shift()}function g(){if(!j){d();
return true}return false}return{dispatch:function(k){if("string"===typeof(k)&&k.match(/^https?:\/\//)){f.push(k);
return g()}},stats:function(k){if(k in h){return h[k]
}return null}}});ADGEAR.lang.klass("ADGEAR.QueryString",function(e){var d="";
var b={};function c(i){var j={};for(var g in i){j[g]=i[g]
}return j}function a(j){var f,l,h,m,g,k;var n=ADGEAR.lang.safeDecodeURIComponent;
if((typeof j==="string")&&(j!=="")){d=j;if(d.substring(0,1)==="?"){d=d.substring(1)
}l=d.split("&");for(h=0;h<l.length;h++){m=l[h].split("=");
g=n(m.shift());k=((m!=null)&&(m.length>0))?n(m.join("=")):null;
b[g]=k}}else{if(typeof j==="object"){b=c(j);
f=new Array();for(g in b){k=encodeURIComponent(String(g));
if(b[g]!=null){k+="="+encodeURIComponent(String(b[g]))
}f.push(k)}d=f.join("&")}}}if(e!=null){a(e)
}return{toString:function(){return d},toHash:function(){return b
},isEmpty:function(){for(var f in b){if(b.hasOwnProperty(f)){return false
}}return true},update:function(f,g){b[f]=g;
a(b);return this},add:function(f,g){return this.update(f,g)
},del:function(f){delete b[f];a(b);return this
},contains:function(f){return !!(f in b)},get:function(f){if(this.contains(f)){return b[f]
}return null},delAdGearParams:function(){var g={};
for(var f in b){if(!f.match(/^AG_/)){g[f]=b[f]
}}a(g);return this},dup:function(){return ADGEAR.QueryString(this.toHash())
}}});ADGEAR.lang.singleton("ADGEAR.browser",function(){var b=ADGEAR.lang;
var e=null;var d=null;var c=null;var a=null;
return{type:{IE:!!(window.attachEvent&&(b.indexOf(navigator.userAgent,"Opera")===-1)),Opera:b.indexOf(navigator.userAgent,"Opera")>-1,WebKit:b.indexOf(navigator.userAgent,"AppleWebKit/")>-1,Gecko:b.indexOf(navigator.userAgent,"Gecko")>-1&&b.indexOf(navigator.userAgent,"KHTML")===-1,MobileSafari:!!navigator.userAgent.match(/Apple.*Mobile.*Safari/)},topWindow:function(){if(e==null){try{e=window.parent;
while(e&&(e!=e.parent)){e=e.parent}}catch(f){}}return e
},isTopWindow:function(){return(this.topWindow()==window)
},currentQueryString:function(){if(d==null){try{d=ADGEAR.QueryString(window.location.search)
}catch(f){}}return d},trueReferrer:function(){if(c==null){try{c=this.topWindow().document.referrer
}catch(f){}if(c==null){c=""}}return c},trueReferer:function(){return this.trueReferrer()
},trueLocation:function(){if(a==null){try{a=String(this.topWindow().location)
}catch(f){}if(a==null){a=""}}return a},localtime:function(){var h="";
try{var m=new Date();var l=m.getTimezoneOffset();
var g=(l<0?"+":"-");l=Math.abs(l);var k=parseInt(l/60);
var f=(l%60);var j=function(n){n=String(n);
while(n.length<2){n="0"+n}return(n)};h=String(m.getFullYear())+"-"+j(m.getMonth()+1)+"-"+j(m.getDate())+"T"+j(m.getHours())+":"+j(m.getMinutes())+":"+j(m.getSeconds())+g+j(k)+":"+j(f)
}catch(i){}return h}}});ADGEAR.lang.klass("ADGEAR.Environment",function(a){var e={};
var c={};var b="ag"+String(Math.floor(Math.random()*100000000000000));
var i=ADGEAR.EventQueue();var d="http";for(var g in a){e[g]=a[g]
}function h(){e.durl="";e.aurl="";if(("delivery" in e)&&(d in e.delivery)&&("hostname" in e.delivery[d])&&(e.delivery[d]["hostname"]!=="")){e.durl=d+"://"+e.delivery[d]["hostname"]
}if(("assets" in e)&&(d in e.assets)&&("hostname" in e.assets[d])&&(e.assets[d]["hostname"]!=="")){e.aurl=d+"://"+e.assets[d]["hostname"];
if(("bucket" in e.assets[d])&&(e.assets[d]["bucket"]!=="")){e.aurl+="/"+e.assets[d]["bucket"]
}}}function f(n,k){var m=n.indexOf("?");var j=n;
var l="";if(k!==""){if(m<0){l="?"}else{if(m!=(n.length-1)){l="&"
}}j=j+l+k}return j}h();if(window.location.protocol=="https:"){d="https";
h()}return{config:function(){return e},proto:function(){return d
},getSessionId:function(){return b},setSessionId:function(j){b=String(j)
},eventQueue:function(){return i},helloUrl:function(){this.setSessionId(arguments[0]||this.getSessionId());
return this.deliveryUrl("/session.js",{session:this.getSessionId()})
},deliveryUrl:function(n){var l=arguments[1]||{};
var k=ADGEAR.browser;var j=ADGEAR.QueryString({});
if("querystring" in l&&typeof(l.querystring.toHash)!=="undefined"){j=ADGEAR.QueryString(l.querystring.toHash())
}if(String(n).match(/^https?:\/\//)){return f(n,j.toString())
}if(!("cachebust" in l)||(l.cachebust!==false)){j.add("AG_R",String(Math.floor(Math.random()*100000000000000)))
}if(!("localtime" in l)||(l.localtime!==false)){j.add("AG_LT",k.localtime())
}if(!("trueref" in l)||(l.trueref!==false)){j.add("AG_REF",k.trueReferrer())
}if("session" in l){j.add("AG_SESSID",l.session)
}if(!("deliveryhints" in l)||(l.deliveryhints!==false)){for(var m in c){j.add(m,c[m].join(","))
}}return(e.durl+f(n,j.toString()))},assetUrl:function(l){var k=arguments[1]||{};
var j=ADGEAR.QueryString({});if("querystring" in k){j=ADGEAR.QueryString(k.querystring.toHash())
}if(String(l).match(/^https?:\/\//)){return f(l,j.toString())
}if(("cachebust" in k)&&(k.cachebust===true)){j.add("AG_R",String(Math.floor(Math.random()*100000000000000)))
}return(e.aurl+f(l,j.toString()))},addDeliveryHint:function(j,k){if(!(j in c)){c[j]=[]
}c[j].push(k)},isLivePreview:function(){return(("live_preview" in e)&&(e.live_preview===true))
}}});ADGEAR.lang.singleton("ADGEAR.envs",function(){var a={};
return{config:function(c){var b=c.name;if(!(b in a)){a[b]=ADGEAR.Environment(c)
}return a[b]}}});ADGEAR.lang.singleton("ADGEAR.templateApi",function(){return{getClickUrlFromPath:function(c){var b={querystring:arguments[1]||ADGEAR.QueryString({}),cachebust:false,localtime:false,trueref:false,deliveryhints:false};
if(this["adunit_click_url"]){b.querystring.add("AG_RED",this["adunit_click_url"])
}var a=this.env.deliveryUrl(c,b);if(this["source_clicktracker"]){var f;
if(this["source_clicktracker_is_encoded"]){f=ADGEAR.lang.safeDecodeURIComponent(this["source_clicktracker"])
}else{if(this["source_clicktracker_is_double_encoded"]){var e=ADGEAR.lang.safeDecodeURIComponent;
f=e(e(this["source_clicktracker"]))}else{f=this["source_clicktracker"]
}}var d=this["source_clicktracker_expects_encoded"]?encodeURIComponent(a):a;
a=f+d}return a},getClickUrl:function(b){if(!("clicks" in this)||!(b in this["clicks"])){return null
}if(this.env.isLivePreview()){return this.declared_click_urls[b]
}var a=arguments[1]||ADGEAR.QueryString({});
return this.getClickUrlFromPath(this.clicks[b],a)
},getInteractionUrl:function(a){if(("interactions" in this)&&(a in this["interactions"])){return this.env.deliveryUrl(this.interactions[a],{querystring:arguments[1]||ADGEAR.QueryString({}),localtime:false,trueref:false,deliveryhints:false})
}return null},getFileUrl:function(a){if(("files" in this)&&(a in this["files"])){return this.env.assetUrl(this.files[a])
}return null},getVariable:function(a){if(("variables" in this)&&(a in this["variables"])){return this.variables[a]
}return null},getContainerId:function(){return"adgear_"+String(this.instance_id).replace(/-/g,"_")
},getWidth:function(){var a=this["format_width"];
if(a&&String(a)!=="1"){return a}if(this["natural_width"]){return String(this["natural_width"])
}return"500"},getHeight:function(){var a=this["format_height"];
if(a&&String(a)!=="1"){return a}if(this["natural_height"]){return String(this["natural_height"])
}return"500"},getInstanceId:function(){return this.instance_id
},getTxnId:function(){return this.instance_id
},prepThirdParty:function(b){var d=b;var a=this["click_tracker"];
if(String(a).length>0){var c=this["adunit_click_url"];
delete this["adunit_click_url"];d=d.replace(/__CLICK_TRACKER_URL__/g,this.getClickUrlFromPath(a+"?"));
this["adunit_click_url"]=c}d=d.replace(/__RANDOM_NUMBER__/g,Math.floor(Math.random()*100000000000000));
d=d.replace(/__AG_TXN_ID__/g,this.getTxnId());
return d},regClick:function(b){var a=arguments[1]||ADGEAR.QueryString({});
var c=this.getClickUrl(b,a);if(c){ADGEAR.lang.log("AdUnit registered CLICK with name: "+String(b)+" - redirect URL: "+c+" - params: [ "+a.toString()+" ]")
}else{ADGEAR.lang.log("AdUnit attempted to register CLICK with name: "+String(b)+" - params: [ "+a.toString()+" ] - but click NOT FOUND!")
}ADGEAR.browser.topWindow().location=c},regInteraction:function(c){var b=arguments[1]||ADGEAR.QueryString({});
var a=this.env.eventQueue();var d=this.getInteractionUrl(c,b);
if(d){ADGEAR.lang.log("AdUnit registered INTERACTION/EVENT with name: "+String(c)+" - params: [ "+b.toString()+" ]")
}else{ADGEAR.lang.log("AdUnit attempted to register INTERACTION/EVENT with name: "+String(c)+" - params: [ "+b.toString()+" ] - but interaction NOT FOUND!")
}return a.dispatch(d)},getGeoCountryCode:function(){if(("geo" in this)&&("country_code" in this["geo"])){return String(this.geo.country_code)
}return null},getGeoCountryName:function(){if(("geo" in this)&&("country_name" in this["geo"])){return String(this.geo.country_name)
}return null},getGeoRegion:function(){if(("geo" in this)&&("region" in this["geo"])){return String(this.geo.region)
}return null},getGeoCity:function(){if(("geo" in this)&&("city" in this["geo"])){return String(this.geo.city)
}return null},getGeoPostalCode:function(){if(("geo" in this)&&("postal_code" in this["geo"])){return String(this.geo.postal_code)
}return null},getGeoIsp:function(){if(("geo" in this)&&("isp" in this["geo"])){return String(this.geo.isp)
}return null},getGeoNetspeed:function(){if(("geo" in this)&&("netspeed" in this["geo"])){return String(this.geo.netspeed)
}return null},getGeoLongitude:function(){if(("geo" in this)&&("longitude" in this["geo"])){return String(this.geo.longitude)
}return null},getGeoLatitude:function(){if(("geo" in this)&&("latitude" in this["geo"])){return String(this.geo.latitude)
}return null},getGeoDmaCode:function(){if(("geo" in this)&&("dma_code" in this["geo"])){return String(this.geo.dma_code)
}return null},getGeoAreaCode:function(){if(("geo" in this)&&("area_code" in this["geo"])){return String(this.geo.area_code)
}return null},getImpressionHint:function(a){if(("impression_hints" in this)&&(a in this["impression_hints"])){return String(this.impression_hints[a])
}return null},doViewportDetect:function(){return(("viewport_detect" in this)&&(true===this["viewport_detect"])&&!this.env.isLivePreview())
},regOnLoadEvent:function(a){if(typeof window.addEventListener!="undefined"){window.addEventListener("load",a,false)
}else{if(typeof document.addEventListener!="undefined"){document.addEventListener("load",a,false)
}else{if(typeof window.attachEvent!="undefined"){window.attachEvent("onload",a)
}else{if(typeof window.onload=="function"){var b=window.onload;
window.onload=function(){b();a()}}else{window.onload=a
}}}}}}});ADGEAR.render=function(i,j,f){function c(e){if(("placement_id" in e)&&("adunit_id" in e)){e.env.addDeliveryHint("AG_S","p"+String(e.placement_id)+",a"+String(e.adunit_id))
}}function h(o){var p=null;try{if("tilings" in o){p=o.tilings;
if("served" in p){o.env.addDeliveryHint("AG_TS",String(p.served))
}if("unserved" in p){for(var n=0;n<p.unserved.length;
n++){o.env.addDeliveryHint("AG_TN",String(p.unserved[n]))
}}}}catch(e){}}function a(n){for(var e in ADGEAR.templateApi){n[e]=ADGEAR.templateApi[e]
}}function l(e){e.source_clicktracker=null;
e.source_clicktracker_expects_encoded=false;
e.source_clicktracker_is_encoded=false;e.source_clicktracker_is_double_encoded=false;
if((typeof ADGEAR_SOURCE_CLICKTRACKER==="string")&&(String(ADGEAR_SOURCE_CLICKTRACKER).toLowerCase().match(/^http/))){e.source_clicktracker=ADGEAR_SOURCE_CLICKTRACKER
}e.source_clicktracker_expects_encoded=(typeof ADGEAR_SOURCE_CLICKTRACKER_EXPECTS_ENCODED!=="undefined")&&ADGEAR_SOURCE_CLICKTRACKER_EXPECTS_ENCODED;
e.source_clicktracker_is_encoded=(typeof ADGEAR_SOURCE_CLICKTRACKER_IS_ENCODED!=="undefined")&&ADGEAR_SOURCE_CLICKTRACKER_IS_ENCODED;
e.source_clicktracker_is_double_encoded=(typeof ADGEAR_SOURCE_CLICKTRACKER_IS_DOUBLE_ENCODED!=="undefined")&&ADGEAR_SOURCE_CLICKTRACKER_IS_DOUBLE_ENCODED;
ADGEAR_SOURCE_CLICKTRACKER=null;ADGEAR_SOURCE_CLICKTRACKER_EXPECTS_ENCODED=null;
ADGEAR_SOURCE_CLICKTRACKER_IS_ENCODED=null;
ADGEAR_SOURCE_CLICKTRACKER_IS_DOUBLE_ENCODED=null
}function m(e){if(typeof OOBClickTrack==="string"){e.OOBClickTrack=OOBClickTrack
}OOBClickTrack=null}function d(e){if(typeof ADGEAR_ADUNIT_CLICK_URL==="string"&&ADGEAR_ADUNIT_CLICK_URL.toLowerCase().match(/^(http|tel)/)){e.adunit_click_url=ADGEAR_ADUNIT_CLICK_URL
}ADGEAR_ADUNIT_CLICK_URL=null}if(("env" in j)&&("name" in j.env)){var k=ADGEAR.envs.config(j.env);
if(!k){ADGEAR.lang.log("Unable to reference environment specified by AdUnit payload (name = "+String(j.env["name"])+"). Aborting rendering!");
return false}j.env=k;c(j);h(j);l(j);m(j);
d(j);a(j);try{i(j)}catch(g){ADGEAR.lang.log("Failed in executing ad rendering template '"+String(j.template)+"' - placement ID: "+String(j.placement_id)+", adunit ID: "+String(j.adunit_id)+" - in environment '"+String((k.config())["name"])+"'. Exception: "+String(g));
if(f){try{f(j)}catch(b){ADGEAR.lang.log("Failed in executing backup rendering handler provided by '"+String(j.template)+"' - placement ID: "+String(j.placement_id)+", adunit ID: "+String(j.adunit_id)+" - in environment '"+String((k.config())["name"])+"'. Exception: "+String(b))
}}return false}}return true};ADGEAR.lang.namespace("ADGEAR.vendor");
ADGEAR.vendor.Base64={_keyStr:"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=",encode:function(d){var a="";
var l,j,g,k,h,f,e;var b=0;var c=ADGEAR.vendor.Base64;
d=c._utf8_encode(d);while(b<d.length){l=d.charCodeAt(b++);
j=d.charCodeAt(b++);g=d.charCodeAt(b++);k=l>>2;
h=((l&3)<<4)|(j>>4);f=((j&15)<<2)|(g>>6);
e=g&63;if(isNaN(j)){f=e=64}else{if(isNaN(g)){e=64
}}a=a+this._keyStr.charAt(k)+this._keyStr.charAt(h)+this._keyStr.charAt(f)+this._keyStr.charAt(e)
}return a},decode:function(d){var a="";var l,j,g;
var k,h,f,e;var b=0;var c=ADGEAR.vendor.Base64;
d=d.replace(/[^A-Za-z0-9\+\/\=]/g,"");while(b<d.length){k=this._keyStr.indexOf(d.charAt(b++));
h=this._keyStr.indexOf(d.charAt(b++));f=this._keyStr.indexOf(d.charAt(b++));
e=this._keyStr.indexOf(d.charAt(b++));l=(k<<2)|(h>>4);
j=((h&15)<<4)|(f>>2);g=((f&3)<<6)|e;a=a+String.fromCharCode(l);
if(f!=64){a=a+String.fromCharCode(j)}if(e!=64){a=a+String.fromCharCode(g)
}}a=c._utf8_decode(a);return a},_utf8_encode:function(b){b=b.replace(/\r\n/g,"\n");
var a="";for(var e=0;e<b.length;e++){var d=b.charCodeAt(e);
if(d<128){a+=String.fromCharCode(d)}else{if((d>127)&&(d<2048)){a+=String.fromCharCode((d>>6)|192);
a+=String.fromCharCode((d&63)|128)}else{a+=String.fromCharCode((d>>12)|224);
a+=String.fromCharCode(((d>>6)&63)|128);a+=String.fromCharCode((d&63)|128)
}}}return a},_utf8_decode:function(a){var d="";
var b=0;var e=c1=c2=0;while(b<a.length){e=a.charCodeAt(b);
if(e<128){d+=String.fromCharCode(e);b++}else{if((e>191)&&(e<224)){c2=a.charCodeAt(b+1);
d+=String.fromCharCode(((e&31)<<6)|(c2&63));
b+=2}else{c2=a.charCodeAt(b+1);c3=a.charCodeAt(b+2);
d+=String.fromCharCode(((e&15)<<12)|((c2&63)<<6)|(c3&63));
b+=3}}}return d}};ADGEAR.lang.singleton("ADGEAR.viewport",function(){var d=ADGEAR.browser.type;
function b(i){var e=0;var h=0;var g=document.getElementById(i);
var f=g;do{e+=f.offsetTop||0;h+=f.offsetLeft||0
}while(f=f.offsetParent);f=g;do{if(!d.Opera||(f.tagName&&(f.tagName.toUpperCase()=="BODY"))){e-=f.scrollTop||0;
h-=f.scrollLeft||0}}while(f=f.parentNode);
return{left:h,top:e}}function a(g){var j=document.getElementById(g);
var l=j.style.display;if(l!="none"&&l!=null){return{width:j.offsetWidth,height:j.offsetHeight}
}var h=j.style;var m=h.visibility;var k=h.position;
var f=h.display;h.visibility="hidden";h.position="absolute";
h.display="block";var e=j.clientWidth;var i=j.clientHeight;
h.display=f;h.position=k;h.visibility=m;return{width:e,height:i}
}function c(){var h={};var g=["Width","Height"];
for(var f=0;f<g.length;f++){var e=g[f];var j=e.toLowerCase();
if(d.WebKit&&!document.evaluate){h[j]=self["inner"+e]
}else{if((d.Opera&&parseFloat(window.opera.version())<9.5)||(document.documentElement.clientHeight==0)||(d.Gecko&&!(document.body.clientHeight==document.body.offsetHeight&&document.body.clientHeight==document.body.scrollHeight))){h[j]=document.body["client"+e]
}else{h[j]=document.documentElement["client"+e]
}}}return h}return{dimensions:function(){return c()
},isElementVisible:function(h){var g=b(h);
var f=a(h);g.right=g.left+f.width;g.bottom=g.top+f.height;
var e=c();if(g.right>0&&g.left<e.width&&g.bottom>0&&g.top<e.height){return true
}return false},observeAd:function(e){if(ADGEAR.browser.isTopWindow()){if(ADGEAR.viewport.isElementVisible(e.getContainerId())){e.regInteraction("LOADED_IN_VIEWPORT")
}else{var g=function(){if(ADGEAR.viewport.isElementVisible(e.getContainerId())){e.regInteraction("ENTERED_VIEWPORT");
clearInterval(f)}};var f=window.setInterval(g,500)
}}else{e.regInteraction("LOADED_IN_IFRAME")
}}}});ADGEAR.lang.singleton("ADGEAR.v",function(){function f(){return window.BloomGHUaVZLoaded
}function a(){window.BloomGHUaVZLoaded=true
}function e(h){var g=document.createElement("script");
g.type="text/javascript";if(g.readyState){g.onreadystatechange=function(){if(g.readyState=="loaded"||g.readyState=="complete"){g.onreadystatechange=null;
a();h()}}}else{g.onload=function(){a();h()
}}g.src="http://v.adgear.com/v.js";document.body.appendChild(g)
}function b(i,g,h){ADGEAR.lang.log("viewport_sio: attempting to register with sio for ID: "+i+" and container ID: "+String(g.id));
if(window.BloomGJUaVZ){window.BloomGJUaVZ({uid:i,el:g,vars:h});
ADGEAR.lang.log("viewport_sio: REGISTERED with sio for ID: "+i+" and container ID: "+String(g.id))
}}function c(h,g){ADGEAR.lang.log("viewport_sio: observing DOM element: "+g);
var k=document.getElementById(g);if(k){var j=h.env.config();
var i=h.getImpressionHint("url");var l={};
if("name" in j){l.farm=String(j.name);if("placement_id" in h){l.placement_id=String(h.placement_id)
}if("adunit_id" in h){l.adunit_id=String(h.adunit_id)
}}if("rtb_data" in h){if("request_id" in h.rtb_data){l.trader_request_id=String(h.rtb_data["request_id"])
}if("spot_id" in h.rtb_data){l.trader_spot_id=String(h.rtb_data["spot_id"])
}if("flight_id" in h.rtb_data){l.trader_flight_id=String(h.rtb_data["flight_id"])
}if("tag_id" in h.rtb_data){l.trader_tag_id=String(h.rtb_data["tag_id"])
}if("bidder_id" in h.rtb_data){l.trader_bidder_id=String(h.rtb_data["bidder_id"])
}if("exchange_id" in h.rtb_data){l.trader_exchange_id=String(h.rtb_data["exchange_id"])
}if("exchange_seller_id" in h.rtb_data){l.trader_exchange_seller_id=String(h.rtb_data["exchange_seller_id"])
}}if(i!=null){l.url=String(i)}if(f()){ADGEAR.lang.log("viewport_sio: script already loaded, registering with sio for instance ID: "+String(h.instance_id)+" and container ID: "+g);
b(String(h.instance_id),k,l)}else{ADGEAR.lang.log("viewport_sio: script not loaded, loading script then registering with sio for instance ID: "+String(h.instance_id)+" and container ID: "+g);
e(function(){b(String(h.instance_id),k,l)
})}}}function d(h,g){ADGEAR.lang.log("viewport_sio: checking whether to observe ad...");
if(h.doViewportDetect()&&("http"===h.env.proto())){ADGEAR.lang.log("viewport_sio: viewport_detect is turned on for ad and no SSL...");
if(null==document.getElementById(h.getContainerId())){ADGEAR.lang.log("viewport_sio: cannot find DOM element: "+String(h.getContainerId())+" ... registering on load event.");
h.regOnLoadEvent(function(){c(h,g)})}else{ADGEAR.lang.log("viewport_sio: found DOM element: "+String(h.getContainerId())+" ...");
c(h,g)}}}return{observeAd:function(g){d(g,g.getContainerId())
},observeAdInContainer:function(h,g){d(h,g)
}}});try{
/*  SWFObject v2.2 beta1 <http://code.google.com/p/swfobject/>
  is released under the MIT License <http://www.opensource.org/licenses/mit-license.php>
*/
ADGEAR.lang.namespace("ADGEAR.vendor");
ADGEAR.vendor.swfobject=function(){var D="undefined",r="object",S="Shockwave Flash",W="ShockwaveFlash.ShockwaveFlash",q="application/x-shockwave-flash",R="SWFObjectExprInst",x="onreadystatechange",O=window,j=document,t=navigator,T=false,U=[h],o=[],N=[],I=[],l,Q,E,B,J=false,a=false,n,G,m=true,M=function(){var aa=typeof j.getElementById!=D&&typeof j.getElementsByTagName!=D&&typeof j.createElement!=D,ah=t.userAgent.toLowerCase(),Y=t.platform.toLowerCase(),ae=Y?/win/.test(Y):/win/.test(ah),ac=Y?/mac/.test(Y):/mac/.test(ah),af=/webkit/.test(ah)?parseFloat(ah.replace(/^.*webkit\/(\d+(\.\d+)?).*$/,"$1")):false,X=!+"\v1",ag=[0,0,0],ab=null;
if(typeof t.plugins!=D&&typeof t.plugins[S]==r){ab=t.plugins[S].description;
if(ab&&!(typeof t.mimeTypes!=D&&t.mimeTypes[q]&&!t.mimeTypes[q].enabledPlugin)){T=true;
X=false;ab=ab.replace(/^.*\s+(\S+\s+\S+$)/,"$1");
ag[0]=parseInt(ab.replace(/^(.*)\..*$/,"$1"),10);
ag[1]=parseInt(ab.replace(/^.*\.(.*)\s.*$/,"$1"),10);
ag[2]=/[a-zA-Z]/.test(ab)?parseInt(ab.replace(/^.*[a-zA-Z]+(.*)$/,"$1"),10):0
}}else{if(typeof O.ActiveXObject!=D){try{var ad=new ActiveXObject(W);
if(ad){ab=ad.GetVariable("$version");if(ab){X=true;
ab=ab.split(" ")[1].split(",");ag=[parseInt(ab[0],10),parseInt(ab[1],10),parseInt(ab[2],10)]
}}}catch(Z){}}}return{w3:aa,pv:ag,wk:af,ie:X,win:ae,mac:ac}
}(),k=function(){if(!M.w3){return}if((typeof j.readyState!=D&&j.readyState=="complete")||(typeof j.readyState==D&&(j.getElementsByTagName("body")[0]||j.body))){f()
}if(!J){if(typeof j.addEventListener!=D){j.addEventListener("DOMContentLoaded",f,false)
}if(M.ie&&M.win){j.attachEvent(x,function(){if(j.readyState=="complete"){j.detachEvent(x,arguments.callee);
f()}});if(O==top){(function(){if(J){return
}try{j.documentElement.doScroll("left")}catch(X){setTimeout(arguments.callee,0);
return}f()})()}}if(M.wk){(function(){if(J){return
}if(!/loaded|complete/.test(j.readyState)){setTimeout(arguments.callee,0);
return}f()})()}s(f)}}();function f(){if(J){return
}try{var Z=j.getElementsByTagName("body")[0].appendChild(C("span"));
Z.parentNode.removeChild(Z)}catch(aa){return
}J=true;var X=U.length;for(var Y=0;Y<X;Y++){U[Y]()
}}function K(X){if(J){X()}else{U[U.length]=X
}}function s(Y){if(typeof O.addEventListener!=D){O.addEventListener("load",Y,false)
}else{if(typeof j.addEventListener!=D){j.addEventListener("load",Y,false)
}else{if(typeof O.attachEvent!=D){i(O,"onload",Y)
}else{if(typeof O.onload=="function"){var X=O.onload;
O.onload=function(){X();Y()}}else{O.onload=Y
}}}}}function h(){if(T){V()}else{H()}}function V(){var X=j.getElementsByTagName("body")[0];
var aa=C(r);aa.setAttribute("type",q);var Z=X.appendChild(aa);
if(Z){var Y=0;(function(){if(typeof Z.GetVariable!=D){var ab=Z.GetVariable("$version");
if(ab){ab=ab.split(" ")[1].split(",");M.pv=[parseInt(ab[0],10),parseInt(ab[1],10),parseInt(ab[2],10)]
}}else{if(Y<10){Y++;setTimeout(arguments.callee,10);
return}}X.removeChild(aa);Z=null;H()})()}else{H()
}}function H(){var ag=o.length;if(ag>0){for(var af=0;
af<ag;af++){var Y=o[af].id;var ab=o[af].callbackFn;
var aa={success:false,id:Y};if(M.pv[0]>0){var ae=c(Y);
if(ae){if(F(o[af].swfVersion)&&!(M.wk&&M.wk<312)){w(Y,true);
if(ab){aa.success=true;aa.ref=z(Y);ab(aa)
}}else{if(o[af].expressInstall&&A()){var ai={};
ai.data=o[af].expressInstall;ai.width=ae.getAttribute("width")||"0";
ai.height=ae.getAttribute("height")||"0";
if(ae.getAttribute("class")){ai.styleclass=ae.getAttribute("class")
}if(ae.getAttribute("align")){ai.align=ae.getAttribute("align")
}var ah={};var X=ae.getElementsByTagName("param");
var ac=X.length;for(var ad=0;ad<ac;ad++){if(X[ad].getAttribute("name").toLowerCase()!="movie"){ah[X[ad].getAttribute("name")]=X[ad].getAttribute("value")
}}P(ai,ah,Y,ab)}else{p(ae);if(ab){ab(aa)}}}}}else{w(Y,true);
if(ab){var Z=z(Y);if(Z&&typeof Z.SetVariable!=D){aa.success=true;
aa.ref=Z}ab(aa)}}}}}function z(aa){var X=null;
var Y=c(aa);if(Y&&Y.nodeName=="OBJECT"){if(typeof Y.SetVariable!=D){X=Y
}else{var Z=Y.getElementsByTagName(r)[0];
if(Z){X=Z}}}return X}function A(){return !a&&F("6.0.65")&&(M.win||M.mac)&&!(M.wk&&M.wk<312)
}function P(aa,ab,X,Z){a=true;E=Z||null;B={success:false,id:X};
var ae=c(X);if(ae){if(ae.nodeName=="OBJECT"){l=g(ae);
Q=null}else{l=ae;Q=X}aa.id=R;if(typeof aa.width==D||(!/%$/.test(aa.width)&&parseInt(aa.width,10)<310)){aa.width="310"
}if(typeof aa.height==D||(!/%$/.test(aa.height)&&parseInt(aa.height,10)<137)){aa.height="137"
}j.title=j.title.slice(0,47)+" - Flash Player Installation";
var ad=M.ie&&M.win?"ActiveX":"PlugIn",ac="MMredirectURL="+O.location.toString().replace(/&/g,"%26")+"&MMplayerType="+ad+"&MMdoctitle="+j.title;
if(typeof ab.flashvars!=D){ab.flashvars+="&"+ac
}else{ab.flashvars=ac}if(M.ie&&M.win&&ae.readyState!=4){var Y=C("div");
X+="SWFObjectNew";Y.setAttribute("id",X);
ae.parentNode.insertBefore(Y,ae);ae.style.display="none";
(function(){if(ae.readyState==4){ae.parentNode.removeChild(ae)
}else{setTimeout(arguments.callee,10)}})()
}u(aa,ab,X)}}function p(Y){if(M.ie&&M.win&&Y.readyState!=4){var X=C("div");
Y.parentNode.insertBefore(X,Y);X.parentNode.replaceChild(g(Y),X);
Y.style.display="none";(function(){if(Y.readyState==4){Y.parentNode.removeChild(Y)
}else{setTimeout(arguments.callee,10)}})()
}else{Y.parentNode.replaceChild(g(Y),Y)}}function g(ab){var aa=C("div");
if(M.win&&M.ie){aa.innerHTML=ab.innerHTML
}else{var Y=ab.getElementsByTagName(r)[0];
if(Y){var ad=Y.childNodes;if(ad){var X=ad.length;
for(var Z=0;Z<X;Z++){if(!(ad[Z].nodeType==1&&ad[Z].nodeName=="PARAM")&&!(ad[Z].nodeType==8)){aa.appendChild(ad[Z].cloneNode(true))
}}}}}return aa}function u(ai,ag,Y){var X,aa=c(Y);
if(M.wk&&M.wk<312){return X}if(aa){if(typeof ai.id==D){ai.id=Y
}if(M.ie&&M.win){var ah="";for(var ae in ai){if(ai[ae]!=Object.prototype[ae]){if(ae.toLowerCase()=="data"){ag.movie=ai[ae]
}else{if(ae.toLowerCase()=="styleclass"){ah+=' class="'+ai[ae]+'"'
}else{if(ae.toLowerCase()!="classid"){ah+=" "+ae+'="'+ai[ae]+'"'
}}}}}var af="";for(var ad in ag){if(ag[ad]!=Object.prototype[ad]){af+='<param name="'+ad+'" value="'+ag[ad]+'" />'
}}aa.outerHTML='<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"'+ah+">"+af+"</object>";
N[N.length]=ai.id;X=c(ai.id)}else{var Z=C(r);
Z.setAttribute("type",q);for(var ac in ai){if(ai[ac]!=Object.prototype[ac]){if(ac.toLowerCase()=="styleclass"){Z.setAttribute("class",ai[ac])
}else{if(ac.toLowerCase()!="classid"){Z.setAttribute(ac,ai[ac])
}}}}for(var ab in ag){if(ag[ab]!=Object.prototype[ab]&&ab.toLowerCase()!="movie"){e(Z,ab,ag[ab])
}}aa.parentNode.replaceChild(Z,aa);X=Z}}return X
}function e(Z,X,Y){var aa=C("param");aa.setAttribute("name",X);
aa.setAttribute("value",Y);Z.appendChild(aa)
}function y(Y){var X=c(Y);if(X&&X.nodeName=="OBJECT"){if(M.ie&&M.win){X.style.display="none";
(function(){if(X.readyState==4){b(Y)}else{setTimeout(arguments.callee,10)
}})()}else{X.parentNode.removeChild(X)}}}function b(Z){var Y=c(Z);
if(Y){for(var X in Y){if(typeof Y[X]=="function"){Y[X]=null
}}Y.parentNode.removeChild(Y)}}function c(Z){var X=null;
try{X=j.getElementById(Z)}catch(Y){}return X
}function C(X){return j.createElement(X)}function i(Z,X,Y){Z.attachEvent(X,Y);
I[I.length]=[Z,X,Y]}function F(Z){var Y=M.pv,X=Z.split(".");
X[0]=parseInt(X[0],10);X[1]=parseInt(X[1],10)||0;
X[2]=parseInt(X[2],10)||0;return(Y[0]>X[0]||(Y[0]==X[0]&&Y[1]>X[1])||(Y[0]==X[0]&&Y[1]==X[1]&&Y[2]>=X[2]))?true:false
}function v(ac,Y,ad,ab){if(M.ie&&M.mac){return
}var aa=j.getElementsByTagName("head")[0];
if(!aa){return}var X=(ad&&typeof ad=="string")?ad:"screen";
if(ab){n=null;G=null}if(!n||G!=X){var Z=C("style");
Z.setAttribute("type","text/css");Z.setAttribute("media",X);
n=aa.appendChild(Z);if(M.ie&&M.win&&typeof j.styleSheets!=D&&j.styleSheets.length>0){n=j.styleSheets[j.styleSheets.length-1]
}G=X}if(M.ie&&M.win){if(n&&typeof n.addRule==r){n.addRule(ac,Y)
}}else{if(n&&typeof j.createTextNode!=D){n.appendChild(j.createTextNode(ac+" {"+Y+"}"))
}}}function w(Z,X){if(!m){return}var Y=X?"visible":"hidden";
if(J&&c(Z)){c(Z).style.visibility=Y}else{v("#"+Z,"visibility:"+Y)
}}function L(Y){var Z=/[\\\"<>\.;]/;var X=Z.exec(Y)!=null;
return X&&typeof encodeURIComponent!=D?encodeURIComponent(Y):Y
}var d=function(){if(M.ie&&M.win){window.attachEvent("onunload",function(){var ac=I.length;
for(var ab=0;ab<ac;ab++){I[ab][0].detachEvent(I[ab][1],I[ab][2])
}var Z=N.length;for(var aa=0;aa<Z;aa++){y(N[aa])
}for(var Y in M){M[Y]=null}M=null;for(var X in ADGEAR.vendor.swfobject){ADGEAR.vendor.swfobject[X]=null
}ADGEAR.vendor.swfobject=null})}}();return{registerObject:function(ab,X,aa,Z){if(M.w3&&ab&&X){var Y={};
Y.id=ab;Y.swfVersion=X;Y.expressInstall=aa;
Y.callbackFn=Z;o[o.length]=Y;w(ab,false)}else{if(Z){Z({success:false,id:ab})
}}},getObjectById:function(X){if(M.w3){return z(X)
}},embedSWF:function(ac,ai,af,ah,Y,ab,aa,ae,ag,ad){var X={success:false,id:ai};
if(M.w3&&!(M.wk&&M.wk<312)&&ac&&ai&&af&&ah&&Y){w(ai,false);
var Z=function(){af+="";ah+="";var ak={};
if(ag&&typeof ag===r){for(var am in ag){ak[am]=ag[am]
}}ak.data=ac;ak.width=af;ak.height=ah;var an={};
if(ae&&typeof ae===r){for(var al in ae){an[al]=ae[al]
}}if(aa&&typeof aa===r){for(var aj in aa){if(typeof an.flashvars!=D){an.flashvars+="&"+aj+"="+aa[aj]
}else{an.flashvars=aj+"="+aa[aj]}}}if(F(Y)){var ao=u(ak,an,ai);
if(ak.id==ai){w(ai,true)}X.success=true;X.ref=ao
}else{if(ab&&A()){ak.data=ab;P(ak,an,ai,ad);
return}else{w(ai,true)}}if(ad){ad(X)}};if(document.getElementById(ai)){Z()
}else{K(Z)}}else{if(ad){ad(X)}}},switchOffAutoHideShow:function(){m=false
},ua:M,getFlashPlayerVersion:function(){return{major:M.pv[0],minor:M.pv[1],release:M.pv[2]}
},hasFlashPlayerVersion:F,createSWF:function(Z,Y,X){if(M.w3){return u(Z,Y,X)
}else{return undefined}},showExpressInstall:function(Z,aa,X,Y){if(M.w3&&A()){P(Z,aa,X,Y)
}},removeSWF:function(X){if(M.w3){y(X)}},createCSS:function(aa,Z,Y,X){if(M.w3){v(aa,Z,Y,X)
}},addDomLoadEvent:K,addLoadEvent:s,getQueryParamValue:function(aa){var Z=j.location.search||j.location.hash;
if(Z){if(/\?/.test(Z)){Z=Z.split("?")[1]}if(aa==null){return L(Z)
}var Y=Z.split("&");for(var X=0;X<Y.length;
X++){if(Y[X].substring(0,Y[X].indexOf("="))==aa){return L(Y[X].substring((Y[X].indexOf("=")+1)))
}}}return""},expressInstallCallback:function(){if(a){var X=c(R);
if(X&&l){X.parentNode.replaceChild(l,X);if(Q){w(Q,true);
if(M.ie&&M.win){l.style.display="block"}}if(E){E(B)
}}a=false}},check_version:function(X){return F(X)
}}}()}catch(ex){ADGEAR_SWFOBJECT_BROKEN=true
}ADGEAR.render(function(i){document.writeln('<div id="'+i.getContainerId()+'" style="margin:0;padding:0;"></div>');
var a=i.getFileUrl("swf_file");var m=i.getFileUrl("backup_image");
var l=i.getClickUrl("clickTAG");var f=i.getVariable("version")||"8.0.0";
var h=i.getVariable("thirdparty_witness_url");
if(h){var d=i.prepThirdParty(ADGEAR.vendor.Base64.decode(h));
ADGEAR.lang.log("AdGear AdUnit dispatching third-party impression beacon: "+d);
i.env.eventQueue().dispatch(d)}if((typeof ADGEAR_SWFOBJECT_BROKEN==="undefined")&&ADGEAR.vendor.swfobject.check_version(f)){var b={clickTAG:encodeURIComponent(l),clickTag:encodeURIComponent(l)};
if(typeof i.OOBClickTrack!=="undefined"){b.OOBClickTrack=encodeURIComponent(i.OOBClickTrack)
}for(var j in i.variables){if(j.match(/^flashvar_/)){b[encodeURIComponent(j.replace(/^flashvar_/,""))]=encodeURIComponent(ADGEAR.vendor.Base64.decode(i.variables[j]))
}}ADGEAR.vendor.swfobject.embedSWF(a,i.getContainerId(),i.getWidth(),i.getHeight(),f,false,b,{wmode:"opaque",allowscriptaccess:"always"})
}else{if(m){var c=document.createElement("img");
var g=document.createElement("a");c.src=m;
c.style.border="0";g.href=l;g.target="_blank";
g.appendChild(c);if(typeof i.OOBClickTrack!=="undefined"){g.onclick=function(){i.env.eventQueue().dispatch(i.OOBClickTrack)
}}var e=i.getContainerId();var k=function(){document.getElementById(e).appendChild(g)
};if(document.getElementById(e)==null){i.regOnLoadEvent(k)
}else{k()}}}ADGEAR.viewport.observeAd(i);
ADGEAR.v.observeAd(i)},{template:"Standard::Flash",instance_id:"bc306038-b4fe-11e3-94ad-df0566f103f7",env:{assets:{https:{hostname:"acs.adgear.com",bucket:""},http:{hostname:"cdn.adgear.com",bucket:"acs"}},name:"cossette_production",delivery:{https:{hostname:"dcs.adgear.com"},http:{hostname:"dcs.adgear.com"}}},live_preview:false,tilings:{},placement_id:299571,adunit_id:30099,format_width:728,format_height:90,natural_width:728,natural_height:90,impressions_count:4088428,clicks_count:1185,impression_tracker:"",click_tracker:"\/clicks\/thirdparty\/b=VFhOPWJjMzA2MDM4LWI0ZmUtMTFlMy05NGFkLWRmMDU2NmYxMDNmNw**\/p=299571\/a=30099",clicks:{ "clickTAG": "\/clicks\/ext\/b=VFhOPWJjMzA2MDM4LWI0ZmUtMTFlMy05NGFkLWRmMDU2NmYxMDNmNw**\/p=299571\/a=30099\/c=38922" },interactions:{ "LOADED_IN_VIEWPORT": "\/interactions\/ext\/b=VFhOPWJjMzA2MDM4LWI0ZmUtMTFlMy05NGFkLWRmMDU2NmYxMDNmNw**\/p=299571\/a=30099\/i=74122", "LOADED_IN_IFRAME": "\/interactions\/ext\/b=VFhOPWJjMzA2MDM4LWI0ZmUtMTFlMy05NGFkLWRmMDU2NmYxMDNmNw**\/p=299571\/a=30099\/i=74121", "ENTERED_VIEWPORT": "\/interactions\/ext\/b=VFhOPWJjMzA2MDM4LWI0ZmUtMTFlMy05NGFkLWRmMDU2NmYxMDNmNw**\/p=299571\/a=30099\/i=74120" },files:{backup_image:"/assets/2217/30099/20140318145517_0.56285825323549_C1_728X90_TELUS_MARCH_STIM_ANGORA_LGNOKIABB_STATIC_ROC_EN.jpg",swf_file:"/assets/2217/30099/20140318145517_0.800275876753647_C1_728x90_TELUS_MARCH_STIM_ANGORA_NOKIALGBB__ANIMATED_ROC_EN.swf"},geo:{ "country_code": "CA", "country_name": "Canada", "isp": "Bell Canada", "netspeed": "Cable\/DSL", "longitude": "-95.000000", "latitude": "60.000000" },viewport_detect:false,impression_hints:{ },variables:{thirdparty_witness_url:"",flash_version:"8"},declared_click_urls:{clickTAG:"http://www.telus.com/wireless/catalog/?CMP=BACMarSTMATlb"},rtb_data:{ }});