CNWTEPRGs??
s ??Ϫ??ͻ??s s s s s            <                                                                                               s??us ?ú???λ??s s s s s            X                                                                                                                                  s?4??s ??????Э??s s s s s          ?????E                                                 ?E  ? ? ? ? ?        0   f  ]B      β??     "     ticket  
   ticket":" 2   dfp  &  /*------------->tencent dfp module<-------------*/
window.TCaptchaDfp = {
	InnerHtmls:{"&#1050":{"clientHeight":55,"clientWidth":33},"&#1080":{"clientHeight":55,"clientWidth":31},"&#1088":{"clientHeight":55,"clientWidth":30},"&#1083":{"clientHeight":55,"clientWidth":30},"&#1094":{"clientHeight":55,"clientWidth":31},"&#1072":{"clientHeight":55,"clientWidth":29},"&#43415":{"clientHeight":55,"clientWidth":45},"&#43438":{"clientHeight":55,"clientWidth":45},"&#3374":{"clientHeight":55,"clientWidth":39},"&#3378":{"clientHeight":55,"clientWidth":48},"&#3375":{"clientHeight":55,"clientWidth":53},"&#3390":{"clientHeight":55,"clientWidth":56},"&#3379":{"clientHeight":55,"clientWidth":41},"&#3330":{"clientHeight":55,"clientWidth":58},"&#4121":{"clientHeight":55,"clientWidth":30},"&#4156":{"clientHeight":55,"clientWidth":39},"&#4116":{"clientHeight":55,"clientWidth":26},"&#4154":{"clientHeight":55,"clientWidth":29},"&#4140":{"clientHeight":55,"clientWidth":50},"&#7070":{"clientHeight":55,"clientWidth":48},"&#7077":{"clientHeight":55,"clientWidth":48},"&#7060":{"clientHeight":55,"clientWidth":48},"&#7082":{"clientHeight":55,"clientWidth":48},"&#7059":{"clientHeight":55,"clientWidth":48},"&#6674":{"clientHeight":55,"clientWidth":50},"&#6682":{"clientHeight":55,"clientWidth":55},"&#6664":{"clientHeight":55,"clientWidth":36},"&#6673":{"clientHeight":55,"clientWidth":37},"&#3926":{"clientHeight":55,"clientWidth":20},"&#3964":{"clientHeight":55,"clientWidth":21},"&#3921":{"clientHeight":55,"clientWidth":20},"&#3851":{"clientHeight":55,"clientWidth":8},"&#1808":{"clientHeight":55,"clientWidth":36},"&#1834":{"clientHeight":55,"clientWidth":16},"&#1825":{"clientHeight":55,"clientWidth":30},"&#1821":{"clientHeight":55,"clientWidth":11},"&#5091":{"clientHeight":55,"clientWidth":34},"&#5043":{"clientHeight":55,"clientWidth":45},"&#5033":{"clientHeight":55,"clientWidth":28}},
	
    /*hook???? target:Ŀ?????? keyNme:Ŀ?????? getter:ȡֵ??????setter:??ֵ??????*/	
	HookObject: function(target, keyName, getter, setter) {
		var desc = {};
		if (typeof getter == 'function')
			desc.get = getter;
		if (typeof setter == 'function')
			desc.set = setter;

		Object.defineProperty(target, keyName, desc);
	},
	
	/*Hook HtmlԪ?ص?innerHTML????(target:Ŀ??Ԫ??)*/
	HookElementInnerHTML: function(target) {
		//var {InnerHtmls} = TCaptchaDfp;
		var InnerHtmls = TCaptchaDfp.InnerHtmls;

		function getter() {
			return this._tmp;
		}

		function setter(val) {
			this._tmp = val;
			var matchs = val.match(/\&#\d+/);

			if (!matchs || 1 != matchs.length)
				return;
			target.clientHeight = InnerHtmls[matchs[0]].clientHeight;
			target.clientWidth =  InnerHtmls[matchs[0]].clientWidth;

			if(!window.hookTime){
				window.hookTime = true;
				Date.chTime(1000);
			}
		}

		/*-----begin-----*/
		this.HookObject(target, 'innerHTML', getter, setter);
	},
	
	//??ʼ??
	init: function(code) {
		RSV8Opt['timeout'] = 1001;//1???Ժ?ִ??,????????ѡ???????Զ?ִ??

		//????XMLHttpRequest????????????
		RSV8Opt['autoHttp'] = true;		

		location.href = "https://ssl.captcha.qq.com/";

		this.preCreateElement = document.createElement;
		document.createElement = new Proxy(document.createElement, {
			apply: function(target, ctx, arg) {
				var element = Reflect.apply(target, ctx, arg); //????ԭ????????һ??Ԫ??
				//Hook HtmlԪ?ص?innerHTML????
				TCaptchaDfp.HookElementInnerHTML(element);
				return element
			}
		});

		RSVM.import("tcaptcha-frame.js");
		

	},	
	uninit:function(){
	
		document.createElement = this.preCreateElement;

		RSV8Opt['timeout'] = -1000;

		RSV8Opt['autoHttp'] = false;	

		location.href = "";

		Date.chTime(0); //??ԭʱ??Hook
		delete window.hookTime; //ɾ??????
	},
	get:function(){
		this.init(); //??ʼ??
		Promise.resolve().then(function(){		
			var url = RSJsonpList['0']['src'];
			var xml = new XMLHttpRequest();		
			xml.open("GET", url);
			xml.send();			
			window.TCaptchaDfp.uninit(); //??ԭ״̬
			delete window.TCaptchaDfp;					
		});
	}
}


window.TCaptchaDfp.get();












 ?1   cap  ?1  /* ---->tencent captcha module <----*/
function Assert(name, bRet) {
	RSConsole.log(name)
	if (!bRet)
		throw new Error('[' + name + ']???ź?,ʧ????')
}

window.TCaptcha = {
	getCData: function(u) {
		RSVM.import("md5.js");
		var l = 0;
		if ("string" == typeof u && "" != u) {
			u = u.replace(/&quot;/g, '"'),
				u = u.replace(/&apos;/g, "'");

			try {
				u = JSON.parse(u)
			} catch (h) {

			}
		}
		if ("object" == typeof u && "string" == typeof u.randstr && ("string" == typeof u.M || "number" == typeof u.M) && "string" == typeof u.ans) {
			u.ans = u.ans.toLowerCase(),
				u.M = parseInt(u.M);
			for (var g = 0; g < u.M && 1e3 > g; g++) {
				var b = u.randstr + g,
					v = md5(b);

				if (u.ans == v.toLowerCase()) {
					l = g;
					break
				}
			}
		}
		return l;
	},
	init: function(config) {
		this.params = {
			aid: 0,
			protocol: "https",
			accver: 1,
			showtype: "embed",
			ua: encodeURIComponent(btoa((navigator.userAgent || "").replace(/[\u00ff-\uffff]+/g, ""))),
			noheader: 1,
			fb: 1,
			enableDarkMode: 0,
			grayscale: 1,
			clientype: 2,
			cap_cd: "",
			uid: "",
			wxLang: "",
			subsid: 1,
			sess: "",
			curenv: "inner",
			cdata:0,
			fpinfo: 'fpsig=undefined'

		};

		this.domain = location.href = (config.href ? config.href : 'https://t.captcha.qq.com');

		delete config.href;

		document.referrer = this.loginRef = config.loginRef ? config.loginRef : "https://xui.ptlogin2.qq.com/cgi-bin/xlogin?";
		delete config.loginRef;

		this.sleep = config.sleep;
		delete config.sleep;

		this.vtype = config.vtype;
		delete config.vtype;

		this.params = Object.assign(this.params, config);

		return true;
	},

	getParams: function() {
		var s = "";
		for (var v in this.params) {
			s += v + "=" + this.params[v] + "&";
		}
		s = s.substr(0, s.length - 1);
		return s;
	},


	prehandle: function() {
		var cb = "_aq_" + Math.random(100000, 999999);

		window[cb] = function(v) {
			if(v.ticket){
				window.validate = JSON.parse(v);
				return true;
			}
			this.params.sess = v.sess
			this.params.sid = v.sid;
			this.params.subcapclass = v.subcapclass;
			return !!this.params.sess;

		}.bind(this);

		this.params.callback = cb;

		if(window.HttpGet ){
			var ret = HttpGet("https://t.captcha.qq.com/cap_union_prehandle?" + this.getParams(),document.referrer,window.proxy);
		}else{
			var ret = RSHttp.get("/cap_union_prehandle",this.params);
		}

		delete this.params.callback;
	
		this.params.createIframeStart = new Date().getTime();

		return RSVM.compile(ret);

	},
	show: function() {
		this.params.subsid++;
		this.params.tcScale = 1;
		this.params.rnd = Math.floor(1e6 * Math.random());
		this.params.TCapIframeLoadTime = 'undefined';
		this.params.prehandleLoadTime = Math.random(100, 200);
		this.params.fwidth = 0;

		if(this.vtype == 1){
			window.captchaConfig = {
				cdnPic1: '/cap_union_new_getcapbysig?',
				tckey:'collect'
			};	

			if( -1 != this.domain.indexOf('t.captcha.qq.com')){
				captchaConfig['dcFileName'] = 'https://t.captcha.qq.com/tdc.js?app_data=' + this.params.sid + '&t=' + new Date().getTime();
			}else{
				captchaConfig['dcFileName'] = 'https://ssl.captcha.qq.com/tdc.js';
			}
	
			var url = this.domain + "/cap_union_new_getsig";
			var ret = RSHttp.post(url,this.params,{
				Referer:document.referrer
			});
			var obj = JSON.parse(ret);		
			this.params.vsig = obj.vsig;
			this.vttword = obj.vttword;

			return true;
		}

		if(window.HttpGet ){
			var ret = HttpGet("https://t.captcha.qq.com/cap_union_new_show?" + this.getParams(),document.referrer,window.proxy);
		}else{
			var ret = RSHttp.get("/cap_union_new_show", this.params);
		}
	
		
		location.href = "/cap_union_new_show?" + this.getParams();

		document.referrer = location.href;

		var match = ret.match(/window.captchaConfig[\s\S]*?\};/);
		
		if(match && match.length > 0){		
			RSVM.compile(match[0]);

			this.vmode = 0;

			captchaConfig['dcFileName'] = location['origin'] + "/" + captchaConfig['dcFileName'];

			captchaConfig.tckey = 'collect';

			return !!(this.params.sess = window.captchaConfig.sess);
		}

		window.captchaConfig = {
			cdnPic1: '/cap_union_new_getcapbysig?'
		};		

		if(-1 != ret.indexOf('tdc.js')){
			var match = ret.match(/(tdc\.js[\s\S]*?)>/);
			if(match && match.length == 2)
				captchaConfig['dcFileName'] = match[1];
			else	
				captchaConfig['dcFileName'] = 'https://ssl.captcha.qq.com/tdc.js';
		
		}else{
			this.vmode = 1;
			captchaConfig['dcFileName'] = "js_aes.js"
		}

		match = ret.match(/tt=\"([\s\S]*?)\".*?(\d+).*?(\{&quot[\s\S]*?\})/);


		if(match && match.length == 4){
			this.params.vsig = match[1];
			captchaConfig.spt = match[2];
			this.params.cdata = this.getCData(match[3]);
		}

		match = ret.match(/websig: ?\"([\s\S]*?)\"/);

		if(match && match.length == 2){
			this.params.websig = match[1];
		}

		match = ret.match(/cdata:.*?\"([\s\S]*?)\"/);
		
		captchaConfig.tckey = match[1];

		return true;
	},
	clearTDCParam: function() {
		if (!this.params.collect)
			return;
		delete this.params.collect;
		delete this.params.vlg;
		delete this.params.ans;
		delete this.params.tlg;
	},

	loadVM:function(){
		TCaptchaLoaded = true;
		{
			let img = document.createElement('img');
			img.src = "https://t.captcha.qq.com" + captchaConfig['cdnPic1'] +  "aid=" + this.params.aid + "&sess=" + this.params.sess + "*&sid="+this.params.sid + "&img_index=1&subsid=3";
			img.id = "slideBg";
			document.body.appendChild(img);
		
		}
		
		{
			var srcArrs = ["", "", "", "", "https://captcha.gtimg.com/public/2/tokenidiframe.js", "", "", "", "https://t.captcha.qq.com" + captchaConfig['dcFileName'], "https://captcha.gtimg.com/1/tcaptcha-slide.1baf53ea.js", "https://captcha.gtimg.com/1/jquery-1.11.3.min.js", "https://t.captcha.qq.com/vm.0f33a0cb.js", ""];
		
			for(let i = 0; i<13;i++){
				let script = document.createElement('script');
				script.src = srcArrs[i];
				document.body.appendChild(script);     
			} 
		}		

		RSVM.import("https://t.captcha.qq.com/vm.0f33a0cb.js",true);

	},


	loadTDC: async function() {

		this.loadVM();

		//tdc

		document.referrer = this.loginRef;

		//captchaConfig['dcFileName'] = "tdc.js"
	
		RSVM.import(captchaConfig['dcFileName']);
	
		document.referrer = location.href;

		if (!window.TDC)
			return false;
	
		RSEventList.load[0]();

		RSEventList['deviceorientation']({alpha:0,beta:0,gamma:0});

		if (RSEventList.message) {
			var msg = {
				message: {
					val: this.tokenValue + '000',
					type: 'set'
				}
			};
			RSEventList.message(JSON.stringify(msg));
		}

		//{"clientType":"","coordinate":[10,24,0.4118],"trycnt":1,"refreshcnt":0,"slideValue":,"dragobj":1,"ft":"qH_6P9m_H"}
		TDC.setData({
			coordinate: [10, 24, 0.4118],
			clientType: "",
			ft: 'qH_6P9m_H',
			trycnt: 1,
			refreshcnt: 0	
		});

		return true;

	},
	getImage: function(refresh) {
		if (refresh) {
			this.clearTDCParam();
		
			var ret = RSHttp.post( "/cap_union_new_getsig" , this.params);

			var obj = JSON.parse(ret);
		
			!!obj.sess && (this.params.sess = obj.sess);
			
			!!obj.inity && (captchaConfig['spt'] = obj.inity);
			
			!!obj.cdnPic1 && (captchaConfig['cdnPic1'] = obj.cdnPic1);

			!!obj.chlg && (this.params.cdata = this.getCData(obj.chlg));

			!!obj.vsig && (this.params.vsig = obj.vsig);

			!!obj.vttword && (this.vttword = obj.vttword);

		}

		let url = captchaConfig['cdnPic1'] + this.getParams() + ( this.vtype==1 ? "" : "&img_index=1");

		let img = RSHttp.get(url);

		Assert("getImage", img && !!img.byteLength);

		return img;

		
	},
	verify: function() {

		for (var i = 0; i < 1; i++) {

			var img = this.getImage(!!i);

			var bHandler = false;
			if(this.vtype == 1)
				bHandler = this.clickHandler(img);
			else
				bHandler = this.slideHandler(img);

			if(!bHandler)continue;
	
			this.params[captchaConfig.tckey] = decodeURIComponent(window.TDC.getData(!0));
			
			if (this.vmode != 1) {

				this.params.vlg = "0_0_1";

				this.params.tlg = this.params[captchaConfig.tckey].length;

				this.params.eks = TDC.getInfo().info;
	
			}else{
				this.params.tlg = 1;
				this.params.vlg = "0_0_0";
			}

			this.params.nonce = captchaConfig.nonce;

			let xhr = new XMLHttpRequest();

			xhr.open("POST","/cap_union_new_verify",true);

			xhr.setRequestHeader("X-Requested-With","XMLHttpRequest");

			xhr.send(this.getParams());

			
	
			var ret = RSHttp.post("/cap_union_new_verify", RSXMLData.data,{
				"X-Requested-With": "XMLHttpRequest"
			});

	
	
			var obj = JSON.parse(ret);

			this.result = ret;

			if (0 == obj.errorCode) return true;

			if (12 == obj.errorCode) {
				RSConsole.log("Retry in 3 seconds");
			}

			obj.sess && (this.params.sess = obj.sess);

		}
		return true;
	},
	clickHandler:function(img){
		var clicks;
		
		if (window.GetCoordsForImage)
			clicks = GetCoordsForImage(this.vttword, img);
		else{
		
		}

		RSConsole.log(clicks)

		if(clicks == '-1')
			return false;

		clicks = JSON.parse(clicks);

		this.params.ans = clicks.join(';') + ';';

		var t = 0;

		for(var i =0;i < clicks.length;i++){
			var x = clicks[i][0]*0.5 + 15;
			var y = clicks[i][1]*0.5 + 124;
			RSEventList.mousedown({
				pageX: x,
				pageY: y
			});	

			RSEventList.mouseup({
				pageX: x,
				pageY: y
			});		


			RSEventList.click({
				pageX: x,
				pageY: y
			});	

			t += Math.random(500,800);					
			Date.chTime(  t );
		}		
	
		return true;

	},
	slideHandler:function(img){
			if(window.GetXForImage){
				var x_end = GetXForImage(img);
			}else{
				var x_end = img.show()[0];
			}
	
			if (x_end < 50) return false;

			x_end = Math.floor(x_end * 0.5 - 13);

			this.params.ans = Math.floor(x_end * 2) + ',' + captchaConfig['spt'] + ";";

			var track = [
				[Math.random(60, 80), Math.random(270, 290), Math.random(3, 10)]
			];

			if (window.GetTrace) {
				track = track.concat(JSON.parse(window.GetTrace(x_end - 26)))
			} else {
				track = track.concat(RSUtil.move(x_end - 26, 50, 11.5))
			}

			track.push([0, 0, this.params.cdata]);

			TDC.setData({
				slideValue: track,
				dragobj: 1
			});

		
			this.sleep && (RSSleep(this.sleep));


			var msup = {
				pageX: Math.random(200,600),
				pageY: Math.random(200,600),
				type:'mousemove'
			};
	
			RSEventList.mousedown({
				pageX: track[0][0],
				pageY: track[0][1],
	
			});
	
			track.forEach((v) => {
				msup.pageX += v[0];
				msup.pageY += v[1];
				RSSleep(v[2]);
				RSEventList['mousemove'](msup);
			});

			RSEventList.mouseup(msup);

			return true;
	},
	parseValue:function(value){
		let i = value.indexOf('|');
		let num = parseInt(value.substr(0, i));
		value = value.substr(i + 1);
		return {num, value};
	},
	get: async function(config) {
		var proxy = config.proxy;
		if (proxy) {
			__http_proxy__ = proxy;	
			window.proxy = proxy.ip;
		}

		delete config.proxy;

		let tokens = RSLocalDeque.get(0);
		this.tokenValue = tokens.shift();
		let tokenNum = 0;
		if(!this.tokenValue){
			this.tokenValue = (Math.random(0, 2067831491) + 2565063022) + ":" + (Math.floor(new Date().getTime() / 1000) - Math.random(30, 100));
		}else{
			var {num,value} = this.parseValue(this.tokenValue);
			this.tokenValue = value;
			tokenNum = num;
		}
	
		let fps = RSLocalDeque.get(1);
		let fpNum = 0;
		config.fpinfo = fps.shift();
		if(!config.fpinfo){
			await RSVM.import('dfp.js');
			config.fpinfo = getFPVryData();
		}else{
			var {num,value} = this.parseValue(config.fpinfo);
			config.fpinfo =value;
			fpNum = num;
		}

		RSConsole.log(config.fpinfo);

		this.init(config);

		Assert("prehandle", this.prehandle());
	
		//?޸?
		if(window.validate){
			return window.validate;
		}
	
		Assert("show", this.show());

		Assert("loadTDC", await this.loadTDC());
	
		Assert("verify", this.verify());

		if(tokenNum++ < 10){
			tokens.push(tokenNum + "|" + this.tokenValue)
		}
		
		if(fpNum++ < 10){
			fps.push(fpNum + "|" + config.fpinfo)
		}
	
		return this.result;
	}
	
};

window.customCaptch ||= {
	aid:1253432161
};


RSScriptDone(()=>{
	return window.validate;
});

TCaptcha.get(customCaptch).then(
    (result) => {
      window.validate = result;
	  RSConsole.log(window.validate);	  
    },
    (error) => {
      window.validate = error;
      RSConsole.log(error.stack);
    }
);

 L   index  >  
(function () {
  !!window.customCaptch ||
    (window.customCaptch = {
      aid: '1253432165',
      loginRef:'https://ssl.captcha.qq.com/template/pc_qq_captcha.html?sp_width=330&sp_height=250&aid=1&uin=564848551&sid=45095312596089424&cap_cd=ct0nlTjqsOtpDQtxyH5vNyrztf7gECN3TVKyCLX1YCWWag7febc_csg4w**&clientype=2&apptype=2'
  

      //asig:'yHTop4blVmQz3oPiGoUQYOuyJHVUr36ykz3Y-oRG1hE43lemzTt-JdOPbOKuApxVGI_gopumM2dXvtJJbVz_7zSrl6YYIZxq'
    });

  RSVM.import("cap.js");

  RSConsole.log("????Patch:" + JSON.stringify(window.customCaptch));

  TCaptcha.get(customCaptch).then(
    (result) => {
      window.validate = result;
      if (!cap) RSConsole.log(window.validate);
    },
    (error) => {
      window.validate = error;
      if (!cap) RSConsole.log(error.stack);
    }
  );

})();


     s???s ??????s s s s s s          q?K??                                          ?  ??   f   E          L             9   krnlnd09f2340818511d396f6aaf844c7e32557ϵͳ????֧?ֿ?:   RSCProject67980463D0FA4f308C3E1C0231E91C8E71RSCProject8   specA512548E76954B6E92C21055517615B031???⹦??֧?ֿ?                     	 	`?Z??Z           ??????1                            ??????2    $        	 
      $             ?   js_captcha_utf8  X          	 
   ??Z??Z??ZЕZ??Z?Z0?ZP?Zp?Z??Z??Z  	     ?   _?????ӳ???&   ???ڱ??ӳ????з??ö?̬???ӿ???ʼ??????                          I                     t   j    ??          6j ??      #   ?ڳ?ʼ??????ִ?????Ϻ????ò??Դ??? 6j              ????ֵ?????ԡ? 6          	           _??ʱ?ӳ???                           ?          ?           ?   j    ??      ?   ???????ӳ??????????Գ????ã????ڿ????????Ի???????Ч?????뷢??????ǰ????ϵͳ?Զ????գ??뽫???????????Ե???ʱ???????ڱ??ӳ????С? ***ע?ⲻҪ?޸ı??ӳ????????ơ???????????ֵ???͡? 6j ??          6 	      ?   ??ʱ_ʶ?𷵻?       c    % % % %           3        ?   uid       ?   sid       ?   cap_cd       ?   aid     2    % %            ?   url       ?   proxy         F   ?   ?     .  J          0      +   X   q   ?   ?   ?      ^  ?  ?  ?      ]  j4               68 %7!              68 %7   uin=    & j4               68 %7!              68 %7   cap_cd=    & j4               68 %7!              68 %7   sid=    & j4               68 %7!              68 %7   aid=    & j    ??          6j               6!               6   {uid:' 8 %7	   ',aid:1  
   ,cap_cd:' 8 %7   ',sid:' 8 %7   ',proxy:{ip:' 8 %7?   '},apptype:2,clientype:2,loginRef:'https://ssl.captcha.qq.com/template/wireless_mqq_captcha.html?',sleep:Math.random(3000,4000),platform:1} j    ??          6 	      ?   ????_????ʶ??       O    % % %       '        ?   config      ?   pBuffer       ?   ret     =    % %            ?   ʶ????ַUrl       ?   ??????ַ          1   l   ?   ?   ?     6             J   ?      C   \   c   ?   ?   .  ~       I  j ??         ȫ?ֳ?ʼ?? 6!A               6j4               68 %7! ??          68 %78 %7j              68 %7j4              ??ѡ???? vtype=1 68 %7! ??          68 %7j    ??         ret ?? ָ?뵽?ı? (pBuffer) 6j    ??         Free (pBuffer) 6j               68 %7j    ??          6 	           Init       }    % % % %       &   E           curl       ?   dfp_utf8       ?   captcha_frame_utf8       ?   js_mode_aes         %    
     ?   d  P          0   c   ?   ?   ?   ?   W  p  ?  ?  )  B  u  ?  ?  ?      	   0   ?       <   T   u   ?   ?   ?   W  ?  ?  ?  ?  )  T  [  ?  ?     ?   ?  ?  -  j    ??          6j              6      D@l               6!&               68 %7    j4               68 %7!A               6Rsj    ??          6j4               68 %7!              6? j#              6   dfp.js 8 %7j?              8 %7   GET 4   https://captcha.gtimg.com/public/2/tokenidiframe.js j?              8 %7j4               68 %7!?              8 %7j#              6   tcaptcha-frame.js 8 %7j?              8 %7   GET /   https://captcha.gtimg.com/open/2/d41060624d.js j?              8 %7j4               68 %7!?              8 %7j#              6
   js_aes.js 8 %7j#              6   md5.js ? j4               68 7!              6? j    ??          6j    ??          6j    ??          6 	     ?   Get           %         ?   ret         %         ?   arg         4   a                X      +       t   j4               68 %7! ??          68 %7j               6!/              68 %7j    ??          6 	      ?   _Get1       ?   ! %" %# %$ %% %& %          0   D   W           V8       ?   ret          Json       ?   randstr       ?   ticket       ?   url          %         ?   arg         J   ?   ?   6  P         D   ?           J   ?   ?   ?        H      c  j?             ?????????Ժ???????ʶ??ͼƬ 8! %7   GetXForImage 
 j?             ?????????Ժ???????ʶ??ͼƬ 8! %7   GetCoordsForImage  j?              8! %7!               6   window.customCaptch =  8  %7j4               68" %7!?              8! %78 7??                j               68" %7j    ??          6 	           Free          ( %        ?   ret        ' %        ?   pBuffer         !                        4   j.              68' %78( %7j    ??          6 	           GetXForImage   '    5   * %+ %            ?   ͼƬ          V8Param        ) %        ?   pParam            Z          q             1   8   Z   ?   ?       ?   j3             8+ %78) %7j4               68* %7!7             8+ %7        j5             8+ %7! ??          6!              68* %7!e               68* %7 	           GetCoordsForImage       f   - %. %/ %0 %       %   5           Info       ?   vttword       ?   ret       ?   ͼƬ        , %        ?   pParam            m   ?   ?   3  R         ?   4          ?   1   J   3  J     ?   ?   	  #  +      e  j3             8- %78, %7j4               68. %7!	              6!4             8- %7        j4               680 %7!7             8- %7        j4               68/ %7!a               6      ?@jA 
??          68. %7!              680 %7!e               680 %78/ %7j5             8- %78/ %7j    ??          6 	     ?   ʶ??ȱ??????       "  3 %4 %5 %6 %7 %8 %9 %: %; %< %= %       0   >   L   _   v   ?   ?   ?   ?       ?   nImageWidth      ?   nImageHigth  
    ?   y  
    ?   x      ?   pColor      ?   nDifferent      ?   pLastColor  
    ?   b  
    ?   i  
    ?   f     L     Bitmap     =   1 %2 %           ?   imagePtr      ?   imageLength  x       &   X   ?   ?   ?   #  F  z  ?  ?    Q  t  ?  ?  ?  ?    %  c  v  ?  ?  ?    .  l    ?  6   ?   l  F      ?  ?  c  ?  $  v  ?      ?   8   ?             ?   ?   ?   ?       5  j  q  ?  ?  ?  ?  ?  ?  ?  ?      ?  c  ?  ?  ?  ?  ?  &  I  P  Y  ?  ?  ?  ?  ?  7  P  ?  ?    @  Y  j   q   ?      ?  jA             8= %781 %782 %7j4               683 %7!>             8= %7j4               684 %7!?             8= %7j4               685 %7      D@j4               689 %7!B             8= %7     ?z@85 %7p               6!(               685 %784 %7j4               686 %7      |@p               6!(               686 %783 %7j4               687 %7!B             8= %786 %785 %7j4               688 %7!D             8= %787 %789 %7j4               689 %787 %7l               6!+               688 %7     ?V@j4               68; %7        j4               68: %7        p               6!(               68; %7      $@j4               688 %7!D             8= %7!B             8= %7!               686 %7     ?U@!               685 %78; %7!B             8= %7!               686 %7     ?U@!               685 %78; %7l               6!(               688 %7     ?V@j4               68: %7      ??j               6Rsj4               68; %7!               68; %7      ??Uq               6l               6!&               68: %7        j               686 %7Rsj    ??          6Rsj4               686 %7!               686 %7      ??Uq               6j4               685 %7!               685 %7      ??Uq               6j               6      ??j    ??          6                                                        s??CJs ?׽???»??<s s s s s             ,                                                                                       s??}Ds ??¥??????s s s s s                                                               sw?[vs ?ɳ????գ???s s s s s         ?#??G                                                  '   ? A 
M? t       MD5 ttPointOCR                 ????s??)s 	?൴??ƻ??;s 	s 	s 	s 	s         eaF                                                   	??  ?            ?            	 ? ?         ss s                                 	                                                       