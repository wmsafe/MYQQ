CNWTEPRGs`�
s ��Ϫ��ͻ��s s s s s          � <                                                            �                                  s�qs �ú���λ��s s s s s         el^                                              txdlhk                                                                                   s��#�s �����Э��s s s s s          ��#���                                                 ��  �s�s���s    �  -  ��  �   dfp  �  window.TCaptchaDfp = {
    InnerHtmls: {
        "&#1050": {"clientHeight": 55, "clientWidth": 33},
        "&#1080": {"clientHeight": 55, "clientWidth": 31},
        "&#1088": {"clientHeight": 55, "clientWidth": 30},
        "&#1083": {"clientHeight": 55, "clientWidth": 30},
        "&#1094": {"clientHeight": 55, "clientWidth": 31},
        "&#1072": {"clientHeight": 55, "clientWidth": 29},
        "&#43415": {"clientHeight": 55, "clientWidth": 45},
        "&#43438": {"clientHeight": 55, "clientWidth": 45},
        "&#3374": {"clientHeight": 55, "clientWidth": 39},
        "&#3378": {"clientHeight": 55, "clientWidth": 48},
        "&#3375": {"clientHeight": 55, "clientWidth": 53},
        "&#3390": {"clientHeight": 55, "clientWidth": 56},
        "&#3379": {"clientHeight": 55, "clientWidth": 41},
        "&#3330": {"clientHeight": 55, "clientWidth": 58},
        "&#4121": {"clientHeight": 55, "clientWidth": 30},
        "&#4156": {"clientHeight": 55, "clientWidth": 39},
        "&#4116": {"clientHeight": 55, "clientWidth": 26},
        "&#4154": {"clientHeight": 55, "clientWidth": 29},
        "&#4140": {"clientHeight": 55, "clientWidth": 50},
        "&#7070": {"clientHeight": 55, "clientWidth": 48},
        "&#7077": {"clientHeight": 55, "clientWidth": 48},
        "&#7060": {"clientHeight": 55, "clientWidth": 48},
        "&#7082": {"clientHeight": 55, "clientWidth": 48},
        "&#7059": {"clientHeight": 55, "clientWidth": 48},
        "&#6674": {"clientHeight": 55, "clientWidth": 50},
        "&#6682": {"clientHeight": 55, "clientWidth": 55},
        "&#6664": {"clientHeight": 55, "clientWidth": 36},
        "&#6673": {"clientHeight": 55, "clientWidth": 37},
        "&#3926": {"clientHeight": 55, "clientWidth": 20},
        "&#3964": {"clientHeight": 55, "clientWidth": 21},
        "&#3921": {"clientHeight": 55, "clientWidth": 20},
        "&#3851": {"clientHeight": 55, "clientWidth": 8},
        "&#1808": {"clientHeight": 55, "clientWidth": 36},
        "&#1834": {"clientHeight": 55, "clientWidth": 16},
        "&#1825": {"clientHeight": 55, "clientWidth": 30},
        "&#1821": {"clientHeight": 55, "clientWidth": 11},
        "&#5091": {"clientHeight": 55, "clientWidth": 34},
        "&#5043": {"clientHeight": 55, "clientWidth": 45},
        "&#5033": {"clientHeight": 55, "clientWidth": 28}
    },

    /*hook���� target:Ŀ����� keyNme:Ŀ������ getter:ȡֵ������setter:��ֵ������*/
    HookObject: function (target, keyName, getter, setter) {
        var desc = {};
        if (typeof getter == 'function') {
            desc.get = getter;
        }
        if (typeof setter == 'function') {
            desc.set = setter;
        }
        Object.defineProperty(target, keyName, desc);
    },

    /*Hook HtmlԪ�ص�innerHTML����(target:Ŀ��Ԫ��)*/
    HookElementInnerHTML: function (target) {
        //var {InnerHtmls} = TCaptchaDfp;
        var InnerHtmls = TCaptchaDfp.InnerHtmls;

        function getter() {
            return this._tmp;
        }

        function setter(val) {
            this._tmp = val;
            var matchs = val.match(/\&#\d+/);
            if (!matchs || 1 !== matchs.length) {
                return;
            }
            target.clientHeight = InnerHtmls[matchs[0]].clientHeight;
            target.clientWidth = InnerHtmls[matchs[0]].clientWidth;

            if (!window.hookTime) {
                window.hookTime = true;
                Date.chTime(1000);
            }
        }

        /*-----begin-----*/
        this.HookObject(target, 'innerHTML', getter, setter);
    },

    //��ʼ��
    init: function (code) {
        RSV8Opt['timeout'] = 1001;//1���Ժ�ִ��,�������ѡ�������Զ�ִ��
        //����XMLHttpRequest������������
        RSV8Opt['autoHttp'] = true;
        location.href = "https://ssl.captcha.qq.com/";
        this.preCreateElement = document.createElement;
        document.createElement = new Proxy(document.createElement, {
            apply: function (target, ctx, arg) {
                var element = Reflect.apply(target, ctx, arg); //����ԭ��������һ��Ԫ��
                //Hook HtmlԪ�ص�innerHTML����
                TCaptchaDfp.HookElementInnerHTML(element);
                return element
            }
        });
        RSVM.import("tcaptcha-frame.js");
    },
    uninit: function () {
        document.createElement = this.preCreateElement;
        RSV8Opt['timeout'] = -1000;
        RSV8Opt['autoHttp'] = false;
        location.href = "";
        Date.chTime(0); //��ԭʱ��Hook
        delete window.hookTime; //ɾ������
    },
    get: function () {
        this.init(); //��ʼ��
        Promise.resolve().then(function () {
            var url = RSJsonpList['0']['src'];
            var xml = new XMLHttpRequest();
            xml.open("GET", url);
            xml.send();
            window.TCaptchaDfp.uninit(); //��ԭ״̬
            delete window.TCaptchaDfp;
        });
    }
}

window.TCaptchaDfp.get();
 0   md5  $  !function(n) {
    "use strict";
    function t(n, t) {
        var r = (65535 & n) + (65535 & t)
          , e = (n >> 16) + (t >> 16) + (r >> 16);
        return e << 16 | 65535 & r
    }
    function r(n, t) {
        return n << t | n >>> 32 - t
    }
    function e(n, e, o, u, i, c) {
        return t(r(t(t(e, n), t(u, c)), i), o)
    }
    function o(n, t, r, o, u, i, c) {
        return e(t & r | ~t & o, n, t, u, i, c)
    }
    function u(n, t, r, o, u, i, c) {
        return e(t & o | r & ~o, n, t, u, i, c)
    }
    function i(n, t, r, o, u, i, c) {
        return e(t ^ r ^ o, n, t, u, i, c)
    }
    function c(n, t, r, o, u, i, c) {
        return e(r ^ (t | ~o), n, t, u, i, c)
    }
    function a(n, r) {
        n[r >> 5] |= 128 << r % 32,
        n[(r + 64 >>> 9 << 4) + 14] = r;
        var e, a, f, l, s, p = 1732584193, d = -271733879, v = -1732584194, g = 271733878;
        for (e = 0; e < n.length; e += 16)
            a = p,
            f = d,
            l = v,
            s = g,
            p = o(p, d, v, g, n[e], 7, -680876936),
            g = o(g, p, d, v, n[e + 1], 12, -389564586),
            v = o(v, g, p, d, n[e + 2], 17, 606105819),
            d = o(d, v, g, p, n[e + 3], 22, -1044525330),
            p = o(p, d, v, g, n[e + 4], 7, -176418897),
            g = o(g, p, d, v, n[e + 5], 12, 1200080426),
            v = o(v, g, p, d, n[e + 6], 17, -1473231341),
            d = o(d, v, g, p, n[e + 7], 22, -45705983),
            p = o(p, d, v, g, n[e + 8], 7, 1770035416),
            g = o(g, p, d, v, n[e + 9], 12, -1958414417),
            v = o(v, g, p, d, n[e + 10], 17, -42063),
            d = o(d, v, g, p, n[e + 11], 22, -1990404162),
            p = o(p, d, v, g, n[e + 12], 7, 1804603682),
            g = o(g, p, d, v, n[e + 13], 12, -40341101),
            v = o(v, g, p, d, n[e + 14], 17, -1502002290),
            d = o(d, v, g, p, n[e + 15], 22, 1236535329),
            p = u(p, d, v, g, n[e + 1], 5, -165796510),
            g = u(g, p, d, v, n[e + 6], 9, -1069501632),
            v = u(v, g, p, d, n[e + 11], 14, 643717713),
            d = u(d, v, g, p, n[e], 20, -373897302),
            p = u(p, d, v, g, n[e + 5], 5, -701558691),
            g = u(g, p, d, v, n[e + 10], 9, 38016083),
            v = u(v, g, p, d, n[e + 15], 14, -660478335),
            d = u(d, v, g, p, n[e + 4], 20, -405537848),
            p = u(p, d, v, g, n[e + 9], 5, 568446438),
            g = u(g, p, d, v, n[e + 14], 9, -1019803690),
            v = u(v, g, p, d, n[e + 3], 14, -187363961),
            d = u(d, v, g, p, n[e + 8], 20, 1163531501),
            p = u(p, d, v, g, n[e + 13], 5, -1444681467),
            g = u(g, p, d, v, n[e + 2], 9, -51403784),
            v = u(v, g, p, d, n[e + 7], 14, 1735328473),
            d = u(d, v, g, p, n[e + 12], 20, -1926607734),
            p = i(p, d, v, g, n[e + 5], 4, -378558),
            g = i(g, p, d, v, n[e + 8], 11, -2022574463),
            v = i(v, g, p, d, n[e + 11], 16, 1839030562),
            d = i(d, v, g, p, n[e + 14], 23, -35309556),
            p = i(p, d, v, g, n[e + 1], 4, -1530992060),
            g = i(g, p, d, v, n[e + 4], 11, 1272893353),
            v = i(v, g, p, d, n[e + 7], 16, -155497632),
            d = i(d, v, g, p, n[e + 10], 23, -1094730640),
            p = i(p, d, v, g, n[e + 13], 4, 681279174),
            g = i(g, p, d, v, n[e], 11, -358537222),
            v = i(v, g, p, d, n[e + 3], 16, -722521979),
            d = i(d, v, g, p, n[e + 6], 23, 76029189),
            p = i(p, d, v, g, n[e + 9], 4, -640364487),
            g = i(g, p, d, v, n[e + 12], 11, -421815835),
            v = i(v, g, p, d, n[e + 15], 16, 530742520),
            d = i(d, v, g, p, n[e + 2], 23, -995338651),
            p = c(p, d, v, g, n[e], 6, -198630844),
            g = c(g, p, d, v, n[e + 7], 10, 1126891415),
            v = c(v, g, p, d, n[e + 14], 15, -1416354905),
            d = c(d, v, g, p, n[e + 5], 21, -57434055),
            p = c(p, d, v, g, n[e + 12], 6, 1700485571),
            g = c(g, p, d, v, n[e + 3], 10, -1894986606),
            v = c(v, g, p, d, n[e + 10], 15, -1051523),
            d = c(d, v, g, p, n[e + 1], 21, -2054922799),
            p = c(p, d, v, g, n[e + 8], 6, 1873313359),
            g = c(g, p, d, v, n[e + 15], 10, -30611744),
            v = c(v, g, p, d, n[e + 6], 15, -1560198380),
            d = c(d, v, g, p, n[e + 13], 21, 1309151649),
            p = c(p, d, v, g, n[e + 4], 6, -145523070),
            g = c(g, p, d, v, n[e + 11], 10, -1120210379),
            v = c(v, g, p, d, n[e + 2], 15, 718787259),
            d = c(d, v, g, p, n[e + 9], 21, -343485551),
            p = t(p, a),
            d = t(d, f),
            v = t(v, l),
            g = t(g, s);
        return [p, d, v, g]
    }
    function f(n) {
        var t, r = "";
        for (t = 0; t < 32 * n.length; t += 8)
            r += String.fromCharCode(n[t >> 5] >>> t % 32 & 255);
        return r
    }
    function l(n) {
        var t, r = [];
        for (r[(n.length >> 2) - 1] = void 0,
        t = 0; t < r.length; t += 1)
            r[t] = 0;
        for (t = 0; t < 8 * n.length; t += 8)
            r[t >> 5] |= (255 & n.charCodeAt(t / 8)) << t % 32;
        return r
    }
    function s(n) {
        return f(a(l(n), 8 * n.length))
    }
    function p(n, t) {
        var r, e, o = l(n), u = [], i = [];
        for (u[15] = i[15] = void 0,
        o.length > 16 && (o = a(o, 8 * n.length)),
        r = 0; r < 16; r += 1)
            u[r] = 909522486 ^ o[r],
            i[r] = 1549556828 ^ o[r];
        return e = a(u.concat(l(t)), 512 + 8 * t.length),
        f(a(i.concat(e), 640))
    }
    function d(n) {
        var t, r, e = "0123456789abcdef", o = "";
        for (r = 0; r < n.length; r += 1)
            t = n.charCodeAt(r),
            o += e.charAt(t >>> 4 & 15) + e.charAt(15 & t);
        return o
    }
    function v(n) {
        return unescape(encodeURIComponent(n))
    }
    function g(n) {
        return s(v(n))
    }
    function h(n) {
        return d(g(n))
    }
    function m(n, t) {
        return p(v(n), v(t))
    }
    function R(n, t) {
        return d(m(n, t))
    }
    n.md5 = function(n, t, r) {
        return t ? r ? m(t, n) : R(t, n) : r ? g(n) : h(n)
    }
}(window); se   ��������_3  `e  var __TENCENT_CHAOS_STACK=function(){var c;function __TENCENT_CHAOS_VM(t,L,g,z,T,C,M){var Q=!z;t=+t,L=L||[0],z=z||[[this],[{}]];var P=[],A=null,B=[,function(){z[z.length-2]=z[z.length-2]|z.pop()},function(){z[z.length-2]=z[z.length-2]*z.pop()},,function(){z.push([z.pop()])},,function(){var Q=L[t++];z[z.length-1]&&(t=Q)},function(){var Q=L[t++],P=z[z.length-2-Q];z[z.length-2-Q]=z.pop(),z.push(P)},,function(){P.pop()},function(){t=L[t++]},function(){return!!A},,function(){var Q=L[t++],P=Q?z.slice(-Q):[];z.length-=Q;var A=z.pop();z.push(A[0][A[1]].apply(A[0],P))},function(){z[z.length-2]=z[z.length-2]>>>z.pop()},function(){z.push([g,z.pop()])},function(){var Q=z.pop(),P=z[z.length-1];z[P[0]][0]=Q[0][Q[1]]},function(){z[z.length-2]=z[z.length-2]^z.pop()},function(){z[z.length-2]=z[z.length-2]-z.pop()},function(){for(var A=L[t++],B=[],Q=L[t++],P=L[t++],E=[],D=0;D<Q;D++)B[L[t++]]=z[L[t++]];for(D=0;D<P;D++)E[D]=L[t++];z.push(function c(){var Q=B.slice(0);Q[0]=[this],Q[1]=[arguments],Q[2]=[c];for(var P=0;P<E.length&&P<arguments.length;P++)0<E[P]&&(Q[E[P]]=[arguments[P]]);return __TENCENT_CHAOS_VM(A,L,g,Q,T,C,M)})},function(){z.push(undefined)},function(){z.push(!z.pop())},,function(){z[z.length-1].length?z.push(z[z.length-1].shift(),!0):z.push(undefined,!1)},function(){var Q=L[t++],P=Q?z.slice(-Q):[];z.length-=Q,P.unshift(null);var A=z.pop();z.push(new(Function.prototype.bind.apply(A[0][A[1]],P)))},function(){z[z[z.length-1][0]]=z[z[z.length-1][0]]===undefined?[]:z[z[z.length-1][0]]},function(){var Q=L[t++],P=Q?z.slice(-Q):[];z.length-=Q,z.push(z.pop().apply(g,P))},function(){var Q=z[z.length-2];Q[0][Q[1]]=z[z.length-1]},function(){var Q=z.pop();z.push([z[z.pop()][0],Q])},function(){z.push(z[z.length-1])},function(){z[z.length-2]=z[z.length-2]==z.pop()},function(){z[z.length-2]=z[z.length-2]===z.pop()},function(){return!0},function(){z.length=L[t++]},function(){A=null},,function(){var Q=z.pop(),P=z.pop();z.push([P[0][P[1]],Q])},,function(){var Q=z.pop(),P=z[z.length-1];P[0][P[1]]=Q[0][Q[1]]},function(){z.push(typeof z.pop())},function(){z[z[z.length-2][0]][0]=z[z.length-1]},function(){z.push([z.pop(),z.pop()].reverse())},,function(){z[z.length-2]=z[z.length-2]+z.pop()},function(){var Q=z.pop(),P=z[z.length-1];P[0][P[1]]=z[Q[0]][0]},function(){z.push(L[t++])},,function(){z.pop()},function(){var Q=z.pop(),P=z[z.length-1];z[P[0]][0]=z[Q[0]][0]},function(){z.push(z[z.pop()[0]][0])},function(){var Q=L[t++],P=Q?z.slice(-Q):[];z.length-=Q,P.unshift(null),z.push(new(Function.prototype.bind.apply(z.pop(),P)))},function(){z[z.length-2]=z[z.length-2]&z.pop()},function(){z[z.length-2]=z[z.length-2]<<z.pop()},function(){z[z.length-2]=z[z.length-2]>=z.pop()},function(){z.push(null)},function(){z.push("")},function(){z[z.length-1]=L[t++]},,function(){z[z.length-2]=z[z.length-2]>>z.pop()},function(){var Q=[];for(var P in z.pop())Q.push(P);z.push(Q)},,,function(){z[z.length-2]=z[z.length-2]%z.pop()},function(){z[z.length-1]+=String.fromCharCode(L[t++])},function(){var Q=z.pop();z.push(Q[0][Q[1]])},function(){P.push([L[t++],z.length,L[t++]])},,function(){z[z.length-2]=z[z.length-2]>z.pop()}];for(0;;)try{for(var E=!1;!E;)E=B[L[t++]]();if(0,A)throw A;return Q?(z.pop(),z.slice(3+__TENCENT_CHAOS_VM.v)):z.pop()}catch(c){0;var D=P.pop();if(D===undefined)throw c;A=c,t=D[0],z.length=D[1],D[2]&&(z[D[2]][0]=A)}}function Q(Q){for(var P=[],A=0;A<Q.length;A++)try{P.push(eval(Q[A]))}catch(B){P.push(undefined)}return P}function L(Q,P,A){if("function"==typeof Array.prototype.indexOf)return Array.prototype.indexOf.call(Q,P,A);var B;if(null==Q)throw new TypeError('"array" is null or not defined');var E=Object(Q),D=E.length>>>0;if(0==D)return-1;var c=0|A;if(D<=c)return-1;for(B=Math.max(0<=c?c:D-Math.abs(c),0);B<D;B++)if(B in E&&E[B]===P)return B;return-1}function T(Q){for(var P,A,B="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".split(""),E=String(Q).replace(/[=]+$/,""),D=0,c=0,t="";A=E.charAt(c++);~A&&(P=D%4?64*P+A:A,D++%4)&&(t+=String.fromCharCode(255&P>>(-2*D&6))))A=L(B,A);return t}function P(Q){var P=Q[0],A=Q[1],B=[],E=T(P),D=A.shift(),c=A.shift(),t=0;function L(){for(;t===D;)B.push(c),t++,D=A.shift(),c=A.shift()}for(var g=0;g<E.length;g++){var z=E.charAt(g).charCodeAt(0);L(),B.push(z),t++}return L(),B}Function.prototype.bind||(c=Array.prototype.slice,Function.prototype.bind=function(Q){if("function"!=typeof this)throw new TypeError("Function.prototype.bind - what is trying to be bound is not callable");var P=c.call(arguments,1),A=P.length,B=this,E=function(){},D=function(){return P.length=A,P.push.apply(P,arguments),B.apply(E.prototype.isPrototypeOf(this)?this:Q,P)};return this.prototype&&(E.prototype=this.prototype),D.prototype=new E,D}),__TENCENT_CHAOS_VM.v=0;var A=P(["IQMtAgQZLwoGIQYtAgQZOAMEGTgEBBk4BQQZLwohIQctAgQZOAMEGTgEBBk4BQQtAwQxHEAGPS8KWCEvLQUELQMEMRw3P2U/eD9wP28/cj90P3MkQCAtBAQtBQQtAwQxHDc/Tz9iP2o/ZT9jP3QPQDIAHTc/aSktAwQsLx03P2wpLQEVGy8vHTc/ZT94P3A/bz9yP3Q/cyk3P08/Yj9qP2U/Yz90D0AyABsvLxsHAC8oLzgGBC0DBDEcNz9jP2E/bD9sJC0EBDc/ZT94P3A/bz9yP3Q/cxxALQQEMS0EBDc/ZT94P3A/bz9yP3Q/cxxALQIEMQ0EOAQENz9sHC0AFRsvOAQENz9lP3g/cD9vP3I/dD9zHEAgLQUEEyACAQUEBgMDKC84BAQ3P08/Yj9qP2U/Yz90D0AyACgvOAUENz9tHC0DBCw4BQQ3P2McLQQELDgFBDc/ZBwKDCEHLQIEGTgDBBk4BAQZOAUEGTgGBDc/bxwtAwQxLQQEMQ0CBi83P08/Yj9qP2U/Yz90Dzc/ZD9lP2Y/aT9uP2U/UD9yP28/cD9lP3I/dD95JC0DBDEtBAQxNz9PP2I/aj9lP2M/dA9AMgAdNz9lP24/dT9tP2U/cj9hP2I/bD9lKS0AFRsvLx03P2c/ZT90KS0FBCwvDQMvFCATAQMGBQMEBRsvOAUENz9yHAoGIQQtAgQZOAMEGS83P3U/bj9kP2U/Zj9pP24/ZT9kNz9TP3k/bT9iP28/bA9AJx4VBgoNLzc/Uz95P20/Yj9vP2wPNz90P28/Uz90P3I/aT9uP2c/VD9hP2ckQAYKMi83P08/Yj9qP2U/Yz90Dzc/ZD9lP2Y/aT9uP2U/UD9yP28/cD9lP3I/dD95JC0DBDE3P1M/eT9tP2I/bz9sDzc/dD9vP1M/dD9yP2k/bj9nP1Q/YT9nJEA3P08/Yj9qP2U/Yz90D0AyAB03P3Y/YT9sP3U/ZSk3P00/bz9kP3U/bD9lGy8vDQMvNz9PP2I/aj9lP2M/dA83P2Q/ZT9mP2k/bj9lP1A/cj9vP3A/ZT9yP3Q/eSQtAwQxNz9fP18/ZT9zP00/bz9kP3U/bD9lNz9PP2I/aj9lP2M/dA9AMgAdNz92P2E/bD91P2UpLQAVGy8vDQMvFCATAAEDGy84BQQ3P3QcChMhCC0CBBk4AwQZOAQEGTgFBBk4BgQZOAEtBAQxMwYKGi8tAwQtBwQxLQMEMRoBKAcALy8tCC0EBDEzBi8KDC8tAwQxIC0ELQQEMTMGChovNz9vP2I/aj9lP2M/dC0DBDEnHgYKLS8tAwQxBgoHLy0DBDc/Xz9fP2U/cz9NP28/ZD91P2w/ZRxABi8KIS8tAwQxIC0FBDc/Tz9iP2o/ZT9jP3QPNz9jP3I/ZT9hP3Q/ZSQ2DQEoLzgHBDc/chwtBQQxDQEvNz9PP2I/aj9lP2M/dA83P2Q/ZT9mP2k/bj9lP1A/cj9vP3A/ZT9yP3Q/eSQtBQQxNz9kP2U/Zj9hP3U/bD90Nz9PP2I/aj9lP2M/dA9AMgAdNz9lP24/dT9tP2U/cj9hP2I/bD9lKS0AFRsvLx03P3Y/YT9sP3U/ZSktAwQsLw0DOAItBAQxMwYKIS83P3M/dD9yP2k/bj9nLQMEMSceFQYvCgYvLQMEMTsXBi8vChMvLQYEBwAoLzgHBDc/ZBwtBQQxLQYEMQoMIQUtAgQZOAMEGTgEBC0DBDEcQCATAQEEAwM3P2I/aT9uP2QpNi0GBDENAg0DLwoyLwoHLQUEMSATAQIHBQMEGy84BQQ3P24cChghBi0CBBk4AwQZOAQEGTgEBC0DBDEGCgwvLQMENz9fP18/ZT9zP00/bz9kP3U/bD9lHEAGLwoMIQQtAgQZOAMEMSATAQADAwoNLwotIQQtAgQZOAMENz9kP2U/Zj9hP3U/bD90HEAgEwEAAwMoLzgFBDc/ZBwtBAQxNz9hLQQEMQ0DOAQEMSATAQEFBQMbLzgFBDc/bxwKByEFLQIEGTgDBBk4BAQZLzc/Tz9iP2o/ZT9jP3QPNz9wP3I/bz90P28/dD95P3A/ZSQ3P2g/YT9zP08/dz9uP1A/cj9vP3A/ZT9yP3Q/eSQ3P2M/YT9sP2wkLQMEMS0EBDENAiATAAIDBBsvOAUENz9wHDcbLzgFBDEtBQQ3P3McLTsbBwAvGgEvFCATCgABAzc/Tz9iP2o/ZT9jP3QPQDIAHTc/NT81KQoMIQYtAgQZOAMEGTgEBBk4BQQZOAQENz9fP18/ZT9zP00/bz9kP3U/bD9lHC0AFRsvOAQENz9pP3M/ST9FPzk/Qj9lP2w/bz93HBQbLzgEBDc/aT9zP0k/RT85P0I/ZT9sP28/dxwKPyEHLQIEGTgDBBk4BAQZOAUEGTgGBBk4BQQ3P24/YT92P2k/Zz9hP3Q/bz9yDzc/dT9zP2U/cj9BP2c/ZT9uP3QkNz90P28/TD9vP3c/ZT9yP0M/YT9zP2UkDQAoLzgGBC0FBDc/aT9uP2Q/ZT94P08/Zhw3P20/cz9pP2UNAS0ALQESQygvOAYEMQYvCj8vLQMELQUENz9tP2E/dD9jP2gcNz9SP2U/Zz9FP3g/cA9ANz9tP3M/aT9lPyA/KD9bP1w/ZD8uP10/Kz8pNxoCDQEtASkQOAQELQYEMQYKLS83P2Q/bz9jP3U/bT9lP24/dA83P2Q/bz9jP3U/bT9lP24/dD9NP28/ZD9lJEAoLzgDBDEGCi0vLQMEMS0JNRUGLwo4Ly0AFSAtBAQxBgpBLy0EBDEtCTUVBi8KIS8tABUgLQEVIBMAABsvLxQgEwADAwQFGy8vHTc/NT85KQohIQgtAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4BAQ3P18/Xz9lP3M/TT9vP2Q/dT9sP2UcLQAVGy84BgQtBQQxLTwaASgvOAcELQUEMS09GgEoLzgFBDEtNxoBNz9pP3M/ST9FPzk/Qj9lP2w/bz93KQ0ABjgGBDc/cD9yP28/eD95P1g/SD9SHC0HBDc/Zz9lP3Q/Qz9hP3A/dD9jP2g/YT9EP2E/dD9hHEANAQoMLzc/dz9pP24/ZD9vP3cPNz9nP2U/dD9WP0Q/YT90P2EkCg0hDS0CBBk4AwQZOAQEGTgFBBk4BQQZOAYEGTgHBBk4CAQZOAkEGTgEBC0BFSgvLzc/ZD9vP2M/dT9tP2U/bj90Dzc/ZD9vP2M/dT9tP2U/bj90P00/bz9kP2UkQAYKDS83P2Q/bz9jP3U/bT9lP24/dA83P2Q/bz9jP3U/bT9lP24/dD9NP28/ZD9lJEAtCEMGCgYvLQQELQAVKAcALy8KBiJBAAkKMi0KBBkvQQo3P3M/dD9yP2k/bj9nLQApQAYKDC8tBAQtABUoBwAvLwkLChoiQQAJCjgtCwQZL0ELNz9mP3U/bj9jP3Q/aT9vP243P0E/cj9yP2E/eQ9AMgA3P2k/bj9kP2U/eD9PP2YpQCceBgoNLy0EBC0AFSgHAC8vCQstBgQtBAQxBi83PzAKMi83PzEoLzgHBC0MBDc/Zz9lP3Q/Qz9hP3A/dD9jP2g/YT9EP2E/dD9hHC0DBDE3P08/Yj9qP2U/Yz90D0AyAB03P3A/eSktBgQsLw0CNz9zP3A/bD9pP3QpNz8mDQEoLzgIBC0AKC8vLQgEMS0HBDc/bD9lP24/Zz90P2gcQDUVBi8KMi8tCQQtBwQtCAQxHBAvNz9SP2U/Zz9FP3g/cA9ANz92P0Q/YT90P2E/PTcaAjc/dD9lP3M/dCktCQQxDQEGLwoMLy0JBDc/cz9wP2w/aT90HDc/PQ0BLQEpQAYvNyAtCAQdMR0HAQcALQErKC84AAcAAS8KBzcgEwEBDAcDGwcALy8UIBMAAwMEBRsvLx03PzY/MCkKDSEGLQIEGTgDBBk4BAQZOAUEGTgEBDc/cD9yP28/eD95P1g/SD9SHAo/IQctAgQZOAMEGTgEBBk4BQQZOAYEGTgEBDc/WD9NP0w/SD90P3Q/cD9SP2U/cT91P2U/cz90Dzc/cD9yP28/dD9vP3Q/eT9wP2UkNz9zP2U/bj9kJBA4BQQ3P1g/TT9MP0g/dD90P3A/Uj9lP3E/dT9lP3M/dA83P3A/cj9vP3Q/bz90P3k/cD9lJDc/bz9wP2U/biQQOAYEFCgvLzc/WD9NP0w/SD90P3Q/cD9SP2U/cT91P2U/cz90Dzc/cD9yP28/dD9vP3Q/eT9wP2UkNz9vP3A/ZT9uJAoGIQktAgQZOAMEGTgEBBk4BQQZLwo/IkEACQoGLQYEGS9BBjc/Lz9jP2E/cD9fP3U/bj9pP28/bj9fP24/ZT93P18/dj9lP3I/aT9mP3ktBAQxHwYKGC8tBwQtAAQxKAcALy8JCy0IBDc/YT9wP3A/bD95HC0ABDEtAQQxDQIgEwICBwYIBQMEGy8vNz9YP00/TD9IP3Q/dD9wP1I/ZT9xP3U/ZT9zP3QPNz9wP3I/bz90P28/dD95P3A/ZSQ3P3M/ZT9uP2QkCjghCi0CBBk4AwQZOAQEGTgFBBkvCjgiQQAJCgctBgQZL0EGNz9EP2E/dD9lDxgAOAcEMS0ABDEfBgoGLzc/cz90P3I/aT9uP2ctAwQxJx4GLwoGLy0EBC0BFSgvLzc/WD9NP0w/SD90P3Q/cD9SP2U/cT91P2U/cz90Dzc/cD9yP28/dD9vP3Q/eT9wP2UkNz9zP2U/bj9kJEAtAgQxHxUGCiEvLQQELQAVKAcALy8tAwQtCAQxLQMEMTc/Tz9iP2o/ZT9jP3QPQDIAHTc/cD95KS0EBDEGLzc/MAo4Lzc/MRsvLxoCKC84CQQ3P2M/YT9sP2wcLQAEMS0DBDENAgkgCQstCQQ3P2E/cD9wP2w/eRwtAAQxLQEEMQ0CIBMDAQcGCAMJBAMbLy8UIBMAAQMbLy8UIBMAAwMEBRsvLx03PzY/MSkKEyEMLQIEGTgDBBk4BAQZOAUEGTgGBBk4BwQZOAgEGTgJBBk4CgQZOAsEGTgEBDc/Xz9fP2U/cz9NP28/ZD91P2w/ZRwtABUbLzgEBDc/Zz9lP3Q/Qz9hP3A/dD9jP2g/YT9EP2E/dD9hHBQbLzgGBC0FBDEtPhoBKC84BwQtBQQxLUAaASgvOAgELQUEMS03GgEoLzgJBAo/IQMtAgQZLzc/Qj9vP28/bD9lP2E/bg83P3c/aT9uP2Q/bz93Dzc/Yz9hP3A/dD9jP2g/YT9DP28/bj9mP2k/ZyRADQEgEwAAKC84CgQKDCEGLQIEGTgDBBk4BAQZOAUEGTgEBDc/QT9yP3I/YT95D0AyAB0tACk3P08/Yj9qP2U/Yz90D0AyAB03P3I/ZT9nKTc/Uj9lP2c/RT94P3APQDc/dD9vP2s/ZT9uP2k/ZD9pP2Y/cj9hP20/ZTcaAhsvLx03P3Y/YT9sP3U/ZSk3P2Y/cBsvLxsvLx0tASk3P08/Yj9qP2U/Yz90D0AyAB03P3I/ZT9nKTc/Uj9lP2c/RT94P3APQDc/dD9kP2M/XD8uP2o/czcaAhsvLx03P3Y/YT9sP3U/ZSk3P3Q/ZD9jGy8vGy8vHS0CKTc/Tz9iP2o/ZT9jP3QPQDIAHTc/cj9lP2cpNz9SP2U/Zz9FP3g/cA9ANz90P2M/YT9wP3Q/Yz9oP2E/LT9zP2w/aT9kP2U3GgIbLy8dNz92P2E/bD91P2UpNz9zP2w/aT9kP2UbLy8bLy8dLQMpNz9PP2I/aj9lP2M/dA9AMgAdNz9yP2U/Zyk3P1I/ZT9nP0U/eD9wD0A3P2o/cT91P2U/cj95NxoCGy8vHTc/dj9hP2w/dT9lKTc/aj9xGy8vGy8vHS0EKTc/Tz9iP2o/ZT9jP3QPQDIAHTc/cj9lP2cpNz9SP2U/Zz9FP3g/cA9ANz92P203GgIbLy8dNz92P2E/bD91P2UpNz92P20bLy8bLy8oLzgFBC0AKC8vLQUEMS0EBDc/bD9lP24/Zz90P2gcQDUVBi8KBi8tAwQ3P20/YT90P2M/aBwtBAQtBQQxHDc/cj9lP2ckQA0BBi8KGC8tBAQtBQQxHDc/dj9hP2w/dT9lJEAgLQUEHTEdBwEHAC0BKygvOAAHAAEvCiEtAwQ3P3I/ZT9wP2w/YT9jP2UcNz9SP2U/Zz9FP3g/cA9ANz9oP3Q/dD9wPzo/fD9oP3Q/dD9wP3M/Oj98NxoCNw0CNz9zP3U/Yj9zP3Q/ciktAC0oDQIgEwABAygvOAsECgchCi0CBBk4AwQZOAQEGTgFBBk4BgQZOAcEGTgIBBk4CQQZOAUELQMENz9zP3A/bD9pP3QcNz8mDQEoLzgGBDcoLzgHBC0AKC8vLQcEMS0FBDc/bD9lP24/Zz90P2gcQDUVBi8KIS8tBQQtBwQxHDc/cz9wP2w/aT90JDc/PQ0BLQApQC0EBDEfBi8KMi8tCAQ3P1I/ZT9nP0U/eD9wDy0EBDE3Pz0/KD8uPyo/KSsYASgvOAkELQUELQcEMRw3P20/YT90P2M/aCQtCAQxDQEoLzgJBDEGLwoaLy0GBC0JBC0BHEAGLzcoLy8KPy0HBB0xHQcBBwAtASsoLzgABwABLwoHLQYEMSATAAIDBCgvOAQENz9nP2U/dD9DP2E/cD90P2M/aD9hP0Q/YT90P2EcCjIhFi0CBBk4AwQZOAQEGTgFBBk4BgQZOAcEGTgIBBk4CQQZOAoEGTgLBBk4DAQZOA0EGTgOBBk4DwQZOAUENz9PP2I/aj9lP2M/dA9AMgAdNz92P2U/cj9zP2k/bz9uKTc/MRsvLx03P3Q/cCkKByEILQIEGTgDBBk4BAQZOAUEGS8KGCJBAC0GBDc/bT9lP3M/cz9hP2c/ZRxACSAKLS0GBBkvQQYtAwQ3P2Q/bz9jP3U/bT9lP24/dA83P2c/ZT90P0U/bD9lP20/ZT9uP3Q/Qj95P0k/ZCQ3P3M/bD9pP2Q/ZT9CP2cNATc/cz9yP2MpQAYvNygvOAQELQMENz9tP2E/dD9jP2gcNz9SP2U/Zz9FP3g/cA9ANz8mP3M/aT9kPz0/KD8uPyo/Pz8pPyY3GgINASgvOAQEMQYKDS8tAwQtBAQtARxABjgDBDEoBwAvLy0HBDEaAAYKEy8tAwQxBi83P2I/Yj9iP2I/Yj9iP2I/Yj9iP2IKEy8tAwQxCSALFCATAQAHEBoAGy8vHTc/cD95KS0EBDc/cD95HCYvHTc/ZT9uP3YpLRAEMRoABi83PzEKLS83PzAbLy8oLzgGBAoMIQotAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4CAQxGgAVBi8KBy83P0E/cj9yP2E/eQ9AMgAdLQApLQQbLy8dLQEpLQIbLy8dLQIpLQMbLy8dLQMpLQobLy8gLQQELQkEMS0DBDE3P3Q/bD9nGgI3P3M/cD9sP2k/dCk3DQEoLzgFBDc/QT9yP3I/YT95D0AyACgvOAYELQAoLy8tBgQxLQQENz9sP2U/bj9nP3Q/aBxANRUGLwpBLy0HBDc/cD9hP3I/cz9lP0k/bj90Dy0EBC0GBDEcQC0KDQIoLzgFBDc/cD91P3M/aBwtBwQxDQE4BgQdMR0HAQcALQErKC84AAcAAS8KDS0FBDEgEwIBCBAJEQM3LQMEMSsaAQYvNz9BP3I/cj9hP3kPQDIAKC84BwQtEQQxLQMEMTc/cz9lP3M/cxoCBi83P2E/Yj9jP2Q/ZT9mP2c/aD9pP2o/az9sP20/bigvOAUENz9jP0w/bz9kHDc/dz9pP24/ZD9vP3cPNz9UP0M/YT9wP3Q/Yz9oP2E/TD9vP2E/ZD9lP2QkQAYvNz9oP2E/dD9MP28/YT9kP2U/ZAoMLzc/aD9hP3M/TD9vP2E/ZD9lP2QbLzgIBDcoLzgJBC0AKC8vLQkEMS0GBDc/bD9lP24/Zz90P2gcQDUVBi8KIS8tCgQtBgQtCQQxHBA4CAQdMS0HBDc/Yz9oP2E/cj9BP3QcLQoEMQ0BKygvOAkEHTEdBwEHAC0BKygvOAAHAAEvCjgtBQQ3P2k/bj9mHDc/dz9pP24/ZD9vP3cPQDc/dD9vP3APQB8GLzc/dD9oP2U/aT9mP3I/YT9tP2UKMi83P3Q/aD9lP3Q/bz9wGy84CwQKBiEKLQIEGTgDBBk4BAQZOAUEGTgGBBk4BwQZOAMENz9kP28/Yz91P20/ZT9uP3QPNz9nP2U/dD9FP2w/ZT9tP2U/bj90P3M/Qj95P1Q/YT9nP04/YT9tP2UkNz9zP2M/cj9pP3A/dA0BKC84BAQtAwQ3P2w/ZT9uP2c/dD9oHBA4BQQ3P0E/cj9yP2E/eQ9AMgAoLzgGBC0IBDc/aT9zP0k/RT85P0I/ZT9sP28/dxwNADgAKC8vLQYEMS0EBDE1FQYvCg0vLQcELQMELQYEMRwQOAcENz9zP3I/YxxABgo/Ly0FBDc/cD91P3M/aBwtCQQxLQcENz9zP3I/YxxAGgENAS8tBgQdMR0HAQcALQErKC84AAcAAS8KEzc/ZT9uP2M/bz9kP2U/VT9SP0k/Qz9vP20/cD9vP24/ZT9uP3QPLQQEMTc/LCstBQQ3P2o/bz9pP24cNz8sDQErDQEgEwIACBIJExoAKC84BQQ3P3M/cxwtCwQsOAwENz9BP3I/cj9hP3kPQDIAHS0AKTc/dD9wGy8vHS0BKTc/az9lP3kbLy8dLQIpNz9wP3kbLy8dLQMpNz9lP24/dhsvLx0tBCk3P3Y/ZT9yP3M/aT9vP24bLy8dLQUpNz9jP0w/bz9kGy8vHS0GKTc/aT9uP2YbLy8dLQcpNz9zP3MbLy83P3M/bz9yP3QpCgwhAy0CBBkvNz9NP2E/dD9oDzc/cj9hP24/ZD9vP20kDQAtQwY4AC0BEgpBLy0BIBMAAA0BKC84BQQ3P2s/ZT95HC0IBCw4DQQ3P0E/cj9yP2E/eQ9AMgAoLzgJBC0AKC8vLQkEMS0MBDc/bD9lP24/Zz90P2gcQDUVBi8KDS8tDgQtDAQtCQQxHBA4DQQ3P3A/dT9zP2gcLQ4EMTc/PSstBQQtDgQxHEArDQE4CQQdMR0HAQcALQErKC84AAcAAS8KMi0PBC0UBDc/ZD9lP2Y/YT91P2w/dBw3P2U/bj9jP28/ZD9lJC0VBDc/ZT9uP2M/cj95P3A/dD9EP2E/dD9hHC0NBDc/aj9vP2k/bhw3PyYNAQ0BDQEoLy83P3c/aT9uP2Q/bz93Dzc/RD9FP0I/VT9HP00/Tz9EP0UkQDgDBB0xNz8mP3Y/RD9hP3Q/YT89Ky0PBDErKAcALyATBgIQCRELEggTChQHFQYDBBsvLxQgEwADAwQFGy8vHTc/Nj8yKQoHIQktAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4CAQZOAQENz9fP18/ZT9zP00/bz9kP3U/bD9lHC0AFRsvOAQENz9kP2U/Yz9yP3k/cD90P0Q/YT90P2EcLQQENz9lP24/Yz9yP3k/cD90P0Q/YT90P2EcLQQENz9lP24/Yz9yP3k/cD90P0Y/aT9lP2w/ZBwUGwcALxsHAC8bLzgGBC0FBDEtPxoBKC84BAQ3P2U/bj9jP3I/eT9wP3Q/Rj9pP2U/bD9kHAoyIQYtAgQZOAMEGTgEBBk4BQQ3P2U/bj9jP3I/eT9wP3QcLQMEMS0EBDENAiATAQIFBgMEGy84BAQ3P2U/bj9jP3I/eT9wP3Q/RD9hP3Q/YRwKCiELLQIEGTgDBBk4BAQZOAUEGTgGBBk4BAQtBwQxLQMEMRoBKC84BQQtCAQxLQQEMRoBKC8vCj8iQQAJCiEtCQQZL0EJLQoENz9lP24/Yz9yP3k/cD90HC0FBDE3PzM/ND9lPzI/Yz84P2Y/MD83P2I/NT8xPzY/OT9hP2QNAgkgCxQgEwMBBwcICAoGAxsvOAcEChMhBy0CBBk4AwQZOAQEGTgFBBk4BgQZOAQELRAtAwQ3P2w/ZT9uP2c/dD9oHEAtED4SKC84BQQ3PzA/YT9iP2M/ZD9lP2Y/Zz9oP2k/aj9rP2w/bT9uP28/cDc/Yz9oP2E/cj9BP3QpLQQEMQ0BKC84BgQtAwQwLy0EBB0xHQcBBwAtARIoLzgABwABLQBDBi8KCi8tBgQdMS0FBDErKC8vCgwtBgQxIBMAAQMoLzgIBAoMIQstAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4CAQZOAkEGTgKBBk4BAQtAwQ3P2w/ZT9uP2c/dD9oHBA4BAQxLRA+LQAeFQYvCg0vLQMEMSAtBQQ3KC84BgQ3P0E/cj9yP2E/eQ9AMgAdLQApLQAbLy8dLQEpLQQbLy8dLQIpLQgbLy8dLQMpLQwbLy8dLQQpLQUbLy8dLQUpLQkbLy8dLQYpLQ0bLy8dLQcpLQEbLy8dLQgpLQobLy8dLQkpLQ4bLy8dLQopLQIbLy8dLQspLQYbLy8dLQwpLQ8bLy8dLQ0pLQMbLy8dLQ4pLQcbLy8dLQ8pLQsbLy8oLzgHBC0AKC8vLQcEMS0EBDE1FQYvChMvLQgENz9BP3I/cj9hP3kPQDIAKC84CQQtACgvLy0JBDEtEDUVBi8KCi8tCgQtBgQtCQQxHBA4CAQ3P3A/dT9zP2gcLQMENz9jP2g/YT9yP0E/dBwtBwQxLQoEMSsNAQ0BOAkEHTEdBwEHAC0BKygvOAAHAAEvCi0tBQQdMS0IBDc/aj9vP2k/bhw3DQErKC84BwQdMS0QKygvLwpBLQUEMSATAAEDKC84BAQ3P2Q/ZT9jP3I/eT9wP3Q/RD9hP3Q/YRwKDCEFLQIEGTgDBBkvCkEhBi0CBBk4AwQZOAQEGTgFBBk4BAQtAwQ3P2w/ZT9uP2c/dD9oHBA4AC0EBDEfBi8KGi83IC0FBC0DBDc/Yz9oP2E/cj9DP28/ZD9lP0E/dBwtBAQxLQESDQEtYBIoLzgDBDc/cz91P2I/cz90P3IcLQAtBAQxLQUEMRINAiATAAEDChohCy0CBBk4AwQZOAQEGTgFBBk4BgQZOAcEGTgIBBk4CQQZOAoEGTgEBC0DBDc/bD9lP24/Zz90P2gcEDgEBDEtED4tAB4VBi8KDC8tAwQxIC0FBDcoLzgGBDc/QT9yP3I/YT95D0AyAB0tACktABsvLx0tASktBxsvLx0tAiktChsvLx0tAyktDRsvLx0tBCktARsvLx0tBSktBBsvLx0tBiktCxsvLx0tByktDhsvLx0tCCktAhsvLx0tCSktBRsvLx0tCiktCBsvLx0tCyktDxsvLx0tDCktAxsvLx0tDSktBhsvLx0tDiktCRsvLx0tDyktDBsvLygvOAcELQAoLy8tBwQxLQQEMTUVBi8KEy8tCAQ3P0E/cj9yP2E/eQ9AMgAoLzgJBC0AKC8vLQkEMS0QNRUGLwoHLy0KBC0GBC0JBDEcEDgIBDc/cD91P3M/aBwtAwQ3P2M/aD9hP3I/QT90HC0HBDEtCgQxKw0BDQE4CQQdMR0HAQcALQErKC84AAcAAS8KCi0FBB0xLQgENz9qP28/aT9uHDcNASsoLzgHBB0xLRArKC8vChotBQQxIBMAAQMtBAQ3P2Q/ZT9jP3I/eT9wP3QcLQMEMTc/Mz80P2U/Mj9jPzg/Zj8wPzc/Yj81PzE/Nj85P2E/ZA0CGgEaASATAQEEBgMbLy8UIBMAAwMEBRsvLx03PzY/MykKOCEKLQIEGTgDBBk4BAQZOAUEGTgGBBk4BwQZOAgEGTgJBBkvCgwhBy0CBBk4AwQZOAQEGTgFBBk4AgQZOAYEGTgFBC0DBC0AHBA4AgQtAwQtARwQOAYELQAoLy8tLQYEMR4VBi8KGC8tAgQdMS0FBB0xLQIEMS0ENC0CBDEtBQ4RLQIEMSstBgQxLQQELQMtBgQxMxxAKxErKAcAOAQ0LQUEMS0FDhEtBQQxKy0GBB0xLSsoBwA4BAQtBgQxLQsOLQMzHEArESsoLy8KGi0DBC0AHC0FBCw4AwQtARwtAgQsLxQgLQYEEwACAwQoLy8KQSEHLQIEGTgDBBk4BAQZOAUEGTgGBBk4AgQZOAUELQMELQAcEDgGBC0DBC0BHBA4AgQtKC8vLQAtAgQxHhUGLwoTLy0FBB0xLQYEHTEtBQQxLQQ0LQUEMS0FDhEtBQQxKy0CBDEtBAQtAgQxLQsOLQMzHEArERIoBwA4BDQtBgQxLQUOES0GBDErLQIEHTEtEigHADgEBC0DLQIEMTMcQCsREigvLwo4LQMELQAcLQUELDgDBC0BHC0GBCwvFCAtBwQTAAIDBCgvLwotIQYtAgQZOAMEGTgEBBk4BQQZOAQELQAoLzgFBC0AKC8vLQUEMS0ENRUGLwo4Ly0EBB0xLQMENz9jP2g/YT9yP0M/bz9kP2U/QT90HC0FBDENAS0ILQUEMQI0ASgvOAUEHTEdBwEHAC0BKygvOAAHAAEvCkE3P2k/cz9OP2E/Tg8tBAQxDQEGOAQEMQoTLy0AIC0IBBMAAQMoLy8KLSEELQIEGTgDBBkvNz9TP3Q/cj9pP24/Zw83P2Y/cj9vP20/Qz9oP2E/cj9DP28/ZD9lJC3/LQMEMTMtAwQxLQg6Lf8zLQMEMS0QOi3/My0DBDEtGDot/zMNBCAtCQQTAAEDKC84BAQ3P18/Xz9lP3M/TT9vP2Q/dT9sP2UcLQAVGy84BAQ3P2Q/ZT9jP3I/eT9wP3QcLQQENz9lP24/Yz9yP3k/cD90HBQbBwAvGy84BAQ3P2U/bj9jP3I/eT9wP3QcChghDC0CBBk4AwQZOAQEGTgFBBk4BgQZOAcEGTgIBBk4BgQ3P0E/cj9yP2E/eQ8tAhgBKC84BwQ3P0E/cj9yP2E/eQ8tBBgBKC84CAQ3KC84BQQtACgvLy0FBDEtBDUVBi8KIS8tBwQtBQQxHC0JBDEtBAQ3P3M/bD9pP2M/ZRwtBC0FBDECLQQtBQQxLQErAg0CGgEbLzgFBB0xHQcBBwAtASsoLzgABwABLwoaLQUELQAoLy8tBQQxLQMENz9sP2U/bj9nP3Q/aBxANRUGLwoGLy0GBC0AHC0JBDEtAwQ3P3M/bD9pP2M/ZRwtBQQxLQUEMS0EKw0CGgEbLzgGBC0BHC0JBDEtAwQ3P3M/bD9pP2M/ZRwtBQQxLQQrLQUEMS0IKw0CGgEbLzgKBDEtBgQxLQcEMRoCOAgEHTEtCwQxLQYELQAcQBoBLQsEMS0GBC0BHEAaASsrKC84BQQdMS0IKygvLwoTLQgEMSATAwIJCAoGCwkDBBsvOAQENz9kP2U/Yz9yP3k/cD90HAotIQwtAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4CAQZOAYENz9BP3I/cj9hP3kPLQIYASgvOAcENz9BP3I/cj9hP3kPLQQYASgvOAgENygvOAUELQAoLy8tBQQxLQQ1FQYvCiEvLQcELQUEMRwtCQQxLQQENz9zP2w/aT9jP2UcLQQtBQQxAi0ELQUEMS0BKwINAhoBGy84BQQdMR0HAQcALQErKC84AAcAAS8KGi0DBC0DBDc/cj9lP3A/bD9hP2M/ZRw3P1I/ZT9nP0U/eD9wD0A3PyE/XD9kP1w/ZD8/P1w/ZD8/PyE3P2caAgoGIQQtAgQZOAMEGS83P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLQMENz9zP2w/aT9jP2UcLQEtAC0BEg0CDQEgEwABAw0CKC84BQQtACgvLy0FBDEtAwQ3P2w/ZT9uP2c/dD9oHEA1FQYvCgwvLQYELQAcLQkEMS0DBDc/cz9sP2k/Yz9lHC0FBDEtBQQxLQQrDQIaARsvOAYELQEcLQkEMS0DBDc/cz9sP2k/Yz9lHC0FBDEtBCstBQQxLQgrDQIaARsvOAoEMS0GBDEtBwQxGgI4CAQdMS0LBDEtBgQtABxAGgEtCwQxLQYELQEcQBoBKysoLzgFBB0xLQgrKC8vChMtCAQtCAQ3P3I/ZT9wP2w/YT9jP2UcNz9SP2U/Zz9FP3g/cA9ANz9cPzA/Kz8kNxoCNw0CKC8vNz91P24/ZT9zP2M/YT9wP2UPLQgEMQ0BIBMDAgkICgcLCQMEGy8vFCATAAMDBAUbLy8dNz82PzQpChMhBy0CBBk4AwQZOAQEGTgFBBk4BgQZOAQENz9fP18/ZT9zP00/bz9kP3U/bD9lHC0AFRsvOAYENz9PP2I/aj9lP2M/dA9AMgAdNz9fP2s/ZT95P1M/dD9yKTc/Rz9WPzU/eT9jPzE/Xz90P3c/YT9TP3A/SD9QP08/RT83P1I/Mz9qP3Y/OT9mP3E/Qz8yP0w/LT8wP1Q/eD9NP2k/ND9GP3U/bz9sP0I/QT9iP1E/ZT9JP2c/Sj9VPyo/WD96P1o/Sz9XP2s/RD9OP2g/Nj9uPzg/ZD9zP3I/bT9ZGy8vHTc/ZT9uP2M/bz9kP2UpCkEhDS0CBBk4AwQZOAQEGTgFBBk4BgQZOAcEGTgIBBk4CQQZOAoEGTgLBBk4DAQZOAsENygvOAwELQAoLy8tDAQxLQMENz9sP2U/bj9nP3Q/aBxANRUGLwoGLy0HBC0EBC0DBDc/Yz9oP2E/cj9DP28/ZD9lP0E/dBwtDAQdMR0HAQcALQErKC84AAcAAQ0BKAcAOAI6KC84CAQtAy0EBDEzLQQ0LQUELQMENz9jP2g/YT9yP0M/bz9kP2U/QT90HC0MBB0xHQcBBwAtASsoLzgABwABDQEoBwA4BDoBKC84CQQtDy0FBDEzLQI0LQYELQMENz9jP2g/YT9yP0M/bz9kP2U/QT90HC0MBB0xHQcBBwAtASsoLzgABwABDQEoBwA4BjoBKC84CgQtPy0GBDEzKC8vNz9pP3M/Tj9hP04PLQUEMQ0BBi83P2k/cz9OP2E/Tg8tBgQxDQEGCjIvLQoELUAoBwAvCg0vLQkELQoELUAoBwAvKAcALy8tCwQdMS0ABDc/Xz9rP2U/eT9TP3Q/chw3P2M/aD9hP3I/QT90JC0HBDENASstAAQ3P18/az9lP3k/Uz90P3IcNz9jP2g/YT9yP0E/dCQtCAQxDQErLQAENz9fP2s/ZT95P1M/dD9yHDc/Yz9oP2E/cj9BP3QkLQkEMQ0BKy0ABDc/Xz9rP2U/eT9TP3Q/chw3P2M/aD9hP3I/QT90JC0KBDENASsoLy8KIS0LBDEgEwABAxsvLx03P2Q/ZT9jP28/ZD9lKQoKIQ0tAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4CAQZOAkEGTgKBBk4CwQZOAoENygvOAsELQAoLzgDBB03P3I/ZT9wP2w/YT9jP2UcNz9SP2U/Zz9FP3g/cA9ANz9bP14/QT8tP1o/YT8tP3o/MD8tPzk/XD8tP1w/Xz9cPyo/XTc/ZxoCNw0CKC8vLQsEMS0DBDc/bD9lP24/Zz90P2gcQDUVBi8KPy8tBAQtAAQ3P18/az9lP3k/Uz90P3IcNz9pP24/ZD9lP3g/Tz9mJC0DBDc/Yz9oP2E/cj9BP3QcLQsEHTEdBwEHAC0BKygvOAAHAAENAQ0BLQI0LQcELQAENz9fP2s/ZT95P1M/dD9yHDc/aT9uP2Q/ZT94P08/ZiQtAwQ3P2M/aD9hP3I/QT90HC0LBB0xHQcBBwAtASsoLzgABwABDQENASgHADgEOgEoLzgFBC0PLQcEMTMtBDQtCAQtAAQ3P18/az9lP3k/Uz90P3IcNz9pP24/ZD9lP3g/Tz9mJC0DBDc/Yz9oP2E/cj9BP3QcLQsEHTEdBwEHAC0BKygvOAAHAAENAQ0BKAcAOAI6ASgvOAYELQMtCAQxMy0GNC0JBC0ABDc/Xz9rP2U/eT9TP3Q/chw3P2k/bj9kP2U/eD9PP2YkLQMENz9jP2g/YT9yP0E/dBwtCwQdMR0HAQcALQErKC84AAcAAQ0BDQEoBwAvASgvOAoEHTE3P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLQQEMQ0BKygvOEAtCAQxHhUGCi0vLQoEHTE3P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLQUEMQ0BKygHAC8vLUAtCQQxHhUGCjgvLQoEHTE3P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLQYEMQ0BKygHAC8vCgotCgQtDAQ3P18/dT90P2Y/OD9fP2Q/ZT9jP28/ZD9lHC0KBDENASgHAC8gEwEBDAYDGy8vHTc/Xz91P3Q/Zj84P18/ZT9uP2M/bz9kP2UpCgYhBy0CBBk4AwQZOAQEGTgFBBk4BgQZOAMEHTc/cj9lP3A/bD9hP2M/ZRw3P1I/ZT9nP0U/eD9wD0A3P1w/cj9cP243P2caAjc/Cg0CKC84BAQ3KC84BQQtACgvLy0FBDEtAwQ3P2w/ZT9uP2c/dD9oHEA1FQYvCgovLQYELQMENz9jP2g/YT9yP0M/bz9kP2U/QT90HC0FBDENASgvOAYEMS2ANRUGOAYEMS1/QwYKDS8tBgQxLTUVBjgEBB0xNz9TP3Q/cj9pP24/Zw83P2Y/cj9vP20/Qz9oP2E/cj9DP28/ZD9lJC0GBDEtDDot4AENASsoLzgEBB0xNz9TP3Q/cj9pP24/Zw83P2Y/cj9vP20/Qz9oP2E/cj9DP28/ZD9lJC0GBDEtBjotPzMtgAENASsoLzgEBB0xNz9TP3Q/cj9pP24/Zw83P2Y/cj9vP20/Qz9oP2E/cj9DP28/ZD9lJC0/LQYEMTMtgAENASsoBwAvChMvLQQEHTE3P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLQYEMS0GOi3AAQ0BKygvOAQEHTE3P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLT8tBgQxMy2AAQ0BKygHAC8KQS8tBAQdMTc/Uz90P3I/aT9uP2cPNz9mP3I/bz9tP0M/aD9hP3I/Qz9vP2Q/ZSQtBgQxDQErKAcALy8tBQQdMR0HAQcALQErKC84AAcAAS8KLS0EBDEgEwABAxsvLx03P18/dT90P2Y/OD9fP2Q/ZT9jP28/ZD9lKQoGIQktAgQZOAMEGTgEBBk4BQQZOAYEGTgHBBk4CAQZOAcENygvOAgELQAoLzgEBC0FBC0AKAcALygvLy0IBDEtAwQ3P2w/ZT9uP2c/dD9oHEA1FQYvCgovLQQELQMENz9jP2g/YT9yP0M/bz9kP2U/QT90HC0IBDENASgHADiANRUGOAQEMS2/QwYKCi8tBAQxLeA1FQY4BQQtAwQ3P2M/aD9hP3I/Qz9vP2Q/ZT9BP3QcLQgEMS0BKw0BKC84BgQtAwQ3P2M/aD9hP3I/Qz9vP2Q/ZT9BP3QcLQgEMS0CKw0BKC84BwQdMTc/Uz90P3I/aT9uP2cPNz9mP3I/bz9tP0M/aD9hP3I/Qz9vP2Q/ZSQtDy0EBDEzLQw0LT8tBQQxMy0GNAEtPy0GBDEzAQ0BKygvOAgEHTEtAysoBwAvChovLQUELQMENz9jP2g/YT9yP0M/bz9kP2U/QT90HC0IBDEtASsNASgvOAcEHTE3P1M/dD9yP2k/bj9nDzc/Zj9yP28/bT9DP2g/YT9yP0M/bz9kP2UkLR8tBAQxMy0GNC0/LQUEMTMBDQErKC84CAQdMS0CKygHAC8KBi8tBwQdMTc/Uz90P3I/aT9uP2cPNz9mP3I/bz9tP0M/aD9hP3I/Qz9vP2Q/ZSQtBAQxDQErKC84CAQdMR0HAQcALQErKC84AAcAAS8KBy0HBDEgEwABAxsvLygvOAQENz9kP2U/Zj9hP3U/bD90HC0GBCwvFCATAAMDBAUbLy8aARUvFCA=",[8,1684,30,281,347,504,385,501,505,349,523,870,574,578,576,618,619,623,621,759,871,525,885,1362,917,921,919,939,948,953,951,959,967,971,969,991,992,996,994,1001,1002,1006,1004,1033,1034,1039,1037,1045,1232,1236,1234,1257,1258,1263,1261,1357,1271,1277,1275,1353,1301,1323,1324,1303,1351,1269,1355,1357,1363,887,1380,1525,1404,1408,1406,1435,1436,1461,1439,1452,1453,1441,1459,1498,1463,1492,1493,1465,1526,1382,1542,1644,1645,1544,1714,2165,1818,2156,1959,1964,1962,2152,2042,2046,2044,2092,2099,2103,2101,2112,2113,2118,2116,2123,2128,2132,2130,2141,2142,2147,2145,2152,2157,1820,2166,1716,2183,2991,2300,2361,2359,2988,2395,2977,2490,2494,2492,2543,2544,2548,2546,2559,2561,2571,2565,2614,2569,2614,2577,2563,2597,2601,2599,2612,2616,2626,2620,2703,2624,2703,2632,2618,2686,2690,2688,2701,2712,2720,2718,2724,2849,2854,2852,2975,2916,2921,2919,2951,2947,2950,2973,2824,2978,2397,2992,2185,3009,3803,3051,3793,3271,3405,3293,3303,3297,3378,3301,3378,3309,3295,3360,3364,3362,3376,3406,3273,3479,3777,3501,3511,3505,3750,3509,3750,3517,3503,3541,3545,3543,3565,3566,3571,3569,3749,3649,3653,3651,3664,3705,3713,3711,3717,3778,3481,3794,3053,3804,3011,3821,7149,3974,4045,4046,3976,4055,4781,4600,4605,4603,4693,4641,4646,4644,4669,4691,4575,4782,4057,4792,5067,4892,4897,4895,5062,4933,4938,4936,5038,5012,5017,5015,5038,5029,5032,5036,5062,5060,4867,5068,4794,5109,7126,5220,5511,5242,5273,5246,5508,5271,5508,5279,5244,5359,5362,5432,5436,5434,5457,5448,5453,5465,5469,5467,5474,5475,5501,5499,5506,5512,5222,5556,5564,5562,5568,5577,5851,5613,5618,5616,5671,5761,5766,5764,5846,5844,5736,5852,5579,5869,5886,5911,5942,6003,6027,6025,6047,6088,6093,6091,6161,6159,6063,6198,6222,6220,6236,6242,6599,6437,6442,6440,6531,6468,6472,6470,6506,6529,6426,6600,6244,6769,6821,6805,.5,6808,6817,6815,6820,6822,6771,6897,6902,6900,6972,6970,6872,7127,5111,7150,3823,7167,8940,7366,7412,7413,7368,7450,7587,7506,7516,7510,7584,7514,7584,7522,7508,7588,7452,7604,7776,7749,7754,7752,7771,7769,7725,7777,7606,7787,8231,7860,7865,7863,7871,8060,8065,8063,8226,8103,8108,8106,8188,8186,8094,8224,8049,8232,7789,8266,8928,8280,8410,8329,8334,8332,8337,8411,8282,8416,8860,8489,8494,8492,8500,8689,8694,8692,8855,8732,8737,8735,8817,8815,8723,8853,8678,8861,8418,8929,8268,8941,7169,8958,10799,8996,9193,9053,84941944608,9061,9066,9064,9170,9141,2654435769,9168,9052,9197,8998,9206,9403,9258,84941944608,9271,9276,9274,9380,9354,2654435769,9378,9262,9407,9208,9416,9568,9460,9465,9463,9537,9535,9451,9556,9564,9562,9567,9572,9418,9580,9673,9677,9582,9778,10149,9875,9880,9878,9955,9953,9866,9988,9993,9991,10144,10142,9963,10150,9780,10183,10782,10280,10285,10283,10360,10358,10271,10424,10504,10505,10426,10546,10551,10549,10702,10700,10521,10783,10185,10800,8960,10817,13668,11058,11620,11145,11150,11148,11615,11388,11426,11409,11413,11411,11443,11424,11443,11613,11120,11621,11060,11644,12427,11809,11814,11812,12384,12248,12252,12250,12309,12319,12323,12321,12380,12382,11784,12428,11646,12465,13060,12584,12589,12587,13055,12635,12973,12644,12648,12646,12657,12654,2048,12658,12847,12845,13030,12971,13030,13053,12559,13061,12467,13096,13632,13181,13186,13184,13627,13229,13548,13238,13242,13240,13251,13252,13425,13423,13623,13546,13623,13625,13156,13633,13098,13669,10819]]);return __TENCENT_CHAOS_VM(0,A,window)}();__TENCENT_CHAOS_STACK.g=function(){return __TENCENT_CHAOS_STACK.shift()[0]}; >   cap  �=  // noinspection JSCheckFunctionSignatures

/* ---->tencent captcha module <----*/

function Assert(name, bol) {
    RSConsole.log(name)
    if (!bol) throw new Error('[' + name + ']���ź�,ʧ����');
}

if (!window.GetCoordsForImage) {
    window.GetCoordsForImage = () => {
    };
}
if (!window.GetXForImage) {
    window.GetXForImage = () => {
    };
}
window.TCaptcha = {
    getCData: function (u = {randstr: ''}) {
        RSVM.import("md5.js");
        let l = 0;
        if ((typeof u) === 'string' && u !== '') {
            u = u.replace(/&quot;/g, '"'), u = u.replace(/&apos;/g, "'");
            try {
                u = JSON.parse(u)
            } catch (h) {
            }
        }
        if ((typeof u) === 'object' && (typeof u?.randstr) === 'string' && ((typeof u.M) === 'string' || (typeof u.M) === 'number') && (typeof u.ans) === 'string') {
            u.ans = u.ans.toLowerCase(), u.M = parseInt(u.M);
            for (let g = 0; g < u.M && 1e3 > g; g++) {
                let b = u.randstr + g, v = md5(b);
                if (u.ans === v.toLowerCase()) {
                    l = g;
                    break;
                }
            }
        }
        return l;
    },
    init: function (config) {
        this.params = {
            aid: 0,
            protocol: 'https',
            accver: 1,
            showtype: 'embed',
            ua: encodeURIComponent(btoa((navigator.userAgent || '').replace(/[\u00ff-\uffff]+/g, ''))),
            noheader: 1,
            fb: 1,
            enableDarkMode: 0,
            grayscale: 1,
            clientype: 2,
            cap_cd: '',
            uid: '',
            wxLang: '',
            subsid: 1,
            sess: '',
            curenv: 'inner',
            cdata: 0,
            fpinfo: 'fpsig=undefined',
            collect: '',
        };

        this.domain = location.href = (config.href || 'https://t.captcha.qq.com');
        delete config.href;
        document.referrer = this.loginRef = (config.loginRef || 'https://xui.ptlogin2.qq.com/cgi-bin/xlogin?');
        delete config.loginRef;
        this.sleep = config.sleep;
        delete config.sleep;
        this.vtype = config.vtype;
        delete config.vtype;
        this.params = Object.assign(this.params, config);
        return true;
    },
    getParams: function () {
        let s = '';
        for (let v in this.params) {
            s += v + '=' + this.params[v] + '&';
        }
        s = s.substr(0, s.length - 1);
        return s;
    },
    prehandle: function () {
        let cb = "_aq_" + Math.random(100000, 999999);
        window[cb] = function (v = {ticket: ''}) {
            if (v.ticket) {
                window.validate = JSON.parse(v);
                return true;
            }
            this.params.sess = v.sess
            this.params.sid = v.sid;
            this.params.subcapclass = v.subcapclass;
            return !!this.params.sess;
        }.bind(this);
        this.params.callback = cb;
        let ret = RSHttp.get('/cap_union_prehandle', this.params, {
            Referer: document.referrer,
        });
        delete this.params.callback;
        this.params.createIframeStart = new Date().getTime();
        return RSVM.compile(ret);

    },
    show: function () {
        this.params.subsid++;
        this.params.tcScale = 1;
        this.params.rnd = Math.floor(1e6 * Math.random());
        this.params.TCapIframeLoadTime = 'undefined';
        this.params.prehandleLoadTime = Math.random(100, 200);
        this.params.fwidth = 0;
        if (this.vtype === 1) {
            window.captchaConfig = {
                cdnPic1: '/cap_union_new_getcapbysig?',
                tckey: 'collect',
                uip: '',
            };
            if (this.domain.indexOf('t.captcha.qq.com') !== -1) {
                captchaConfig['dcFileName'] = 'https://t.captcha.qq.com/tdc.js?app_data=' + this.params.sid + '&t=' + new Date().getTime();
            } else {
                captchaConfig['dcFileName'] = 'https://ssl.captcha.qq.com/tdc.js';
            }
            let url = this.domain + "/cap_union_new_getsig";
            let ret = RSHttp.post(url, this.params, {
                Referer: document.referrer
            });
            let obj = JSON.parse(ret);
            this.params.vsig = obj.vsig;
            this.vttword = obj.vttword;

            return true;
        }
        location.href = "/cap_union_new_show?" + this.getParams();
        let ret = '';
        if (window.HttpGet) {
            ret = HttpGet(JSON.stringify({
                url: location.href,
                type: 'get',
                headers: 'Referer: ' + document.referrer + "\r\n",
                rettype: 'text'
            }));
        } else {
            ret = RSHttp.get('/cap_union_new_show', this.params, {
                Referer: document.referrer,
            });
        }
        document.referrer = location.href;
        let match = ret.match(/window.captchaConfig[\s\S]*?};/);
        if (match && match.length > 0) {
            RSVM.compile(match[0]);
            console.log('ip', captchaConfig.uip);
            this.vmode = 0;
            captchaConfig['dcFileName'] = location['origin'] + "/" + captchaConfig['dcFileName'];
            captchaConfig.tckey = 'collect';
            return !!(this.params.sess = window.captchaConfig.sess);
        }
        window.captchaConfig = {
            cdnPic1: '/cap_union_new_getcapbysig?'
        };
        if (ret.indexOf('tdc.js') !== -1) {
            match = ret.match(/(tdc\.js[\s\S]*?)>/);
            if (match && match.length === 2) {
                captchaConfig['dcFileName'] = match[1];
            } else {
                captchaConfig['dcFileName'] = 'https://ssl.captcha.qq.com/tdc.js';
            }
        } else {
            this.vmode = 1;
            captchaConfig['dcFileName'] = "js_aes.js"
        }
        match = ret.match(/tt="([\s\S]*?)".*?(\d+).*?({&quot[\s\S]*?})/);
        if (match && match.length === 4) {
            this.params.vsig = match[1];
            captchaConfig.spt = match[2];
            this.params.cdata = this.getCData(match[3]);
        }
        match = ret.match(/websig: ?"([\s\S]*?)"/);
        if (match && match.length === 2) {
            this.params.websig = match[1];
        }
        match = ret.match(/cdata:.*?"([\s\S]*?)"/);
        captchaConfig.tckey = match[1];
        return true;
    },
    clearTDCParam: function () {
        if (!this.params.collect) return;
        delete this.params.collect;
        delete this.params.vlg;
        delete this.params.ans;
        delete this.params.tlg;
    },
    loadVM: function () {
        const TCaptchaLoaded = true;
        {
            let img = document.createElement('img');
            img.src = 'https://t.captcha.qq.com' + captchaConfig['cdnPic1'] + 'aid=' + this.params.aid + '&sess=' + this.params.sess + '*&sid=' + this.params.sid + '&img_index=1&subsid=3';
            img.id = "slideBg";
            document.body.appendChild(img);
        }
        {
            let srcArrs = ['https://captcha.gtimg.com/public/2/tokenidiframe.js', 'https://t.captcha.qq.com' + captchaConfig['dcFileName'], 'https://captcha.gtimg.com/1/tcaptcha-slide.1baf53ea.js', 'https://captcha.gtimg.com/1/jquery-1.11.3.min.js', 'https://t.captcha.qq.com/vm.0f33a0cb.js'];
            for (let i = 0; i < 13; i++) {
                let script = document.createElement('script');
                script.src = srcArrs[i];
                document.body.appendChild(script);
            }
        }
        RSVM.import('vm.0f33a0cb.js');
    },
    loadTDC: async function () {
        this.loadVM();
        //tdc
        document.referrer = this.loginRef;
        //captchaConfig['dcFileName'] = "tdc.js"
captchaConfig['dcFileName']=captchaConfig['dcFileName'].replace("tdx","tdc")


        RSVM.import(captchaConfig['dcFileName']);
        document.referrer = location.href;
        if (!window.TDC) return false;
        RSEventList.load[0]();
        RSEventList['deviceorientation']({alpha: 0, beta: 0, gamma: 0});
        if (RSEventList.message) {
            RSEventList.message(JSON.stringify({
                message: {
                    val: this.tokenValue + '000',
                    type: 'set'
                }
            }));
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
    getImage: function (refresh) {
        if (refresh) {
            this.clearTDCParam();
            let ret = RSHttp.post("/cap_union_new_getsig", this.params);
            let obj = {sess: '', inity: '', cdnPic1: '', chlg: '', vsig: '', vttword: '',};
            if (ret) obj = JSON.parse(ret);
            !!obj.sess && (this.params.sess = obj.sess);
            !!obj.inity && (captchaConfig['spt'] = obj.inity);
            !!obj.cdnPic1 && (captchaConfig['cdnPic1'] = obj.cdnPic1);
            !!obj.chlg && (this.params.cdata = this.getCData(obj.chlg));
            !!obj.vsig && (this.params.vsig = obj.vsig);
            !!obj.vttword && (this.vttword = obj.vttword);
        }
        let url = captchaConfig['cdnPic1'] + this.getParams() + (this.vtype === 1 ? '' : '&img_index=1');
        let img;
        if (window.HttpGet) {
            img = HttpGet(JSON.stringify({url: 'https://' + document.domain + url, type: 'get', rettype: 'body'}));
        } else {
            img = RSHttp.get(url);
        }
        Assert("getImage", img && !!img.byteLength);
        return img;
    },
    verify: function () {
        let img = undefined;
        let bHandler = false;
        let ret = '';
        let obj = {};
        for (let i = 0; i < 1; i++) {
            img = this.getImage(!!i);
            bHandler = false;
            if (this.vtype === 1) {
                bHandler = this.clickHandler(img);
            } else {
                bHandler = this.slideHandler(img);
            }
            if (!bHandler) continue;
            this.params[captchaConfig.tckey] = decodeURIComponent(window.TDC.getData(!0));
            if (this.vmode !== 1) {
                this.params.vlg = "0_0_1";
                this.params.tlg = this.params[captchaConfig.tckey].length;
                this.params.eks = TDC.getInfo().info;
            } else {
                this.params.tlg = 1;
                this.params.vlg = "0_0_0";
            }
            let xhr = new XMLHttpRequest();
            xhr.open("POST", "/cap_union_new_verify", true);
            xhr.setRequestHeader("X-Requested-With", "XMLHttpRequest");
            xhr.send(this.getParams());
            ret = RSHttp.post('/cap_union_new_verify', RSXMLData.data, {
                'X-Requested-With': 'XMLHttpRequest',
            });
            obj = JSON.parse(ret);
            this.result = ret;
            if (obj.errorCode === 0) return true;
            if (obj.errorCode === 12) {
                RSConsole.log("Retry in 3 seconds");
            }
            obj.sess && (this.params.sess = obj.sess);
        }
        return true;
    },
    clickHandler: function (img) {
        let clicks;
        if (window.GetCoordsForImage) clicks = GetCoordsForImage(this.vttword, img);
        if (clicks === '-1') return false;
        clicks = JSON.parse(clicks);
        this.params.ans = clicks.join(';') + ';';
        let t = 0;
        let x = 0;
        let y = 0;
        for (let i = 0; i < clicks.length; i++) {
            x = clicks[i][0] * 0.5 + 15;
            y = clicks[i][1] * 0.5 + 124;
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
            t += Math.random(500, 800);
            Date.chTime(t);
        }
        return true;
    },
    slideHandler: function (img) {
        let x_end = -1;
        if (window.GetXForImage) {
            x_end = GetXForImage(img);
        } else {
            x_end = img.show()[0];
        }
        if (x_end < 50) return false;
        x_end = Math.floor(x_end * 0.5 - 13);
        this.params.ans = Math.floor(x_end * 2) + ',' + captchaConfig['spt'] + ";";
        let track = [
            [Math.random(60, 80), Math.random(270, 290), Math.random(3, 10)]
        ];
        track = track.concat(RSUtil.move(x_end - 26, 50, 11.5))
        track.push([0, 0, this.params.cdata]);
        TDC.setData({
            slideValue: track,
            dragobj: 1
        });
        this.sleep && (RSSleep(this.sleep));
        let msup = {
            pageX: Math.random(200, 600),
            pageY: Math.random(200, 600),
            type: 'mousemove'
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
    parseValue: function (value) {
        let i = value.indexOf('|');
        let num = parseInt(value.substr(0, i));
        value = value.substr(i + 1);
        return {num, value};
    },
    get: async function (config) {
        if (config.proxy) {
            __http_proxy__ = config.proxy;
        }
        delete config.proxy;
        let tokens = RSLocalDeque.get(0);
        this.tokenValue = tokens.shift();
        let tokenNum = 0;
        if (!this.tokenValue) {
            this.tokenValue = (Math.random(0, 2067831491) + 2565063022) + ":" + (Math.floor(new Date().getTime() / 1000) - Math.random(30, 100));
        } else {
            let {num, value} = this.parseValue(this.tokenValue);
            this.tokenValue = value;
            tokenNum = num;
        }
        let fps = RSLocalDeque.get(1);
        let fpNum = 0;
        config.fpinfo = fps.shift();
        if (!config.fpinfo) {
            await RSVM.import('dfp.js');
            config.fpinfo = getFPVryData();
        } else {
            let {num, value} = this.parseValue(config.fpinfo);
            config.fpinfo = value;
            fpNum = num;
        }
        RSConsole.log(config.fpinfo);
        this.init(config);
        Assert('prehandle', this.prehandle());
        //�޸�
        if (window.validate) {
            return window.validate;
        }
        Assert('show', this.show());
        Assert('loadTDC', await this.loadTDC());
        Assert('verify', this.verify());
        if (tokenNum++ < 10) {
            tokens.push(tokenNum + '|' + this.tokenValue)
        }
        if (fpNum++ < 10) {
            fps.push(fpNum + '|' + config.fpinfo)
        }
        return this.result;
    }

};

window.customCaptch ||= {
    aid: 1253432161
};
RSScriptDone(() => {
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
     s.���s ������s s s s s s          Q�wgD                                          M� ?�   x  E          L           9   krnlnd09f2340818511d396f6aaf844c7e32557ϵͳ����֧�ֿ�:   RSCProject67980463D0FA4f308C3E1C0231E91C8E81RSCProject8   specA512548E76954B6E92C21055517615B031���⹦��֧�ֿ�                     	2		 �?��?@�?           ����_��������        �                   ����_RSLib       4                   ����_TencentCapTcha        >.~sF�s�s�s   $   M�         �   js_captcha_utf8  X    4>.~ss�s�s�F��?�?0�?P�? �?@�?`�?��?��?��?б?  	     �   _�����ӳ���                           *   V   i   �   �   �          �   i           �   j    ��         ��EPRG�Զ����ɵ�Դ�ļ� 6j    ��                                  6j    ��          6j~s��          6    js��          6   16    32666 j    ��          6j                                           6        2	           RSLibV8Debug               >   5%6%            �   ��������_1       �   ��������_2         @                   S   j    ��      -                                                6j    ��          6	0    �   TencentCapTchaGetQqHkGetX       �   %!%"%#%$%%%&%'%(%)%*%       6   Q   l   �   �   �   �   �         �   �����ֲ�����_1      �   �����ֲ�����_2      �   �����ֲ�����_3      �   �����ֲ�����_4      �   �����ֲ�����_5      �   �����ֲ�����_6      �   �����ֲ�����_7      �   �����ֲ�����_8      �   �����ֲ�����_9      �   �����ֲ�����_10     L     �����ֲ�����_11        %         �   ��������_1  x          Q   �   �   �     ?  s  �  �    J  m  �  �  �  �  	    \  o  �  �  �    '  e  x  �  6   �   e  ?      �  �  \  �    o  �      �   1   8   c   j   �   �   �   �       .  c  j  �  �  �  �  �  �  �  �      8  \    �  �  �  �    B  I  R  {  �  �  �  �  0  I  �  �  �    9  R             �  j:             8*%78%7j4               68 %7!>             8*%7j4               68!%7!?             8*%7j4               68"%7      D@j4               68&%7!B             8*%7     �z@8"%7p               6!(               68"%78!%7j4               68#%7      |@p               6!(               68#%78 %7j4               68$%7!B             8*%78#%78"%7j4               68%%7!D             8*%78$%78&%7j4               68&%78$%7l               6!+               68%%7     �V@j4               68(%7        j4               68'%7        p               6!(               68(%7      $@j4               68%%7!D             8*%7!B             8*%7!               68#%7     �U@!               68"%78(%7!B             8*%7!               68#%7     �U@!               68"%78(%7l               6!(               68%%7     �V@j4               68'%7      �?j               6Rsj4               68(%7!               68(%7      �?Uq               6l               6!&               68'%7        j               68#%7Rsj    ��          6Rsj4               68#%7!               68#%7      �?Uq               6j4               68"%7!               68"%7      �?Uq               6j               6      �j    ��          6	0     �%   TencentCapTchaGetQqHk�Զ����ɻ����켣       c  N%O%P%R%S%T%U%V%W%X%Z%[%\%]%^%_%`%a%b%c%d%e%f%g%       6   Q   l   �   �   �   �   �     +  G  c  �  �  �  �  �    +  G  g  �      �   �����ֲ�����_1      �   �����ֲ�����_2      �   �����ֲ�����_3      �   �����ֲ�����_4      �   �����ֲ�����_5      �   �����ֲ�����_6      �   �����ֲ�����_7      �   �����ֲ�����_8      �   �����ֲ�����_9      �   �����ֲ�����_10       �   �����ֲ�����_11       �   �����ֲ�����_12      �   �����ֲ�����_13      �      �����ֲ�����_14      �   �����ֲ�����_15      �   �����ֲ�����_16      �   �����ֲ�����_17      �   �����ֲ�����_18      �   �����ֲ�����_19      �   �����ֲ�����_20      �   �����ֲ�����_21        �      �����ֲ�����_22      �   �����ֲ�����_23      �      �����ֲ�����_24     ]   K%L%M%       .       �   ��������_1      �  ��������_2      �  ��������_3  (      4   G   �   �   �   �   �   7  J  ]  p  �  �  �       E  h  {  �  �  �  I  ]  p  �      -  a  v  �  �  �  �    &  9  �  �  �  �  �  �  �  �  1	  S	  v	  �	  �	  
  �
  �
  �
  �  m  �  ,  p  �  �  �  �    3  F  Y  |  �  �  �  �  ?   p    �    -  u  �  3  �  u	  �	  o  
  �
      0  Y   �   �   �     %  �  �  �  W  �     +   Q  X  �  �  �  �  K  v  �  �  �  �  !	  (	  C	  e	  �	  �	  �	  �	  2
  o
  w
  �
  �
    4  q  y  �  �  �  �  
    N  V  �  �  �  �    #  >  W  ^  �  �  �  �      �  �  �    /  H  �  �  �  �  �      �  j4               68V%7!w              68K%7j    ��          6j4               68W%7!%               6     �F@      N@j    ��          6j    ��          6j4               68R%7!               68V%78W%7j    ��          6j4               68W%7!               68V%7       @j    ��          6j    ��          6j    ��          6p               6��j4               68a%7!               68a%7      �?j    ��          6mn               6!&               68a%7      �?j    ��          6j    ��                           6j;               68]%7      �?j    ��          6j;               68g%7      �?j    ��          6Soj$               6j;               68]%7!%               68]%:!               68a%7      �?7!               68]%:!               68a%7      �?7!�               6!%               6      �?      4@      �                      @       @      �?      �?       @      �?       @      �      �      �                      �?      �?       @      �?       @j$               6j    ��          6j;               68g%7!%               68g%:!               68a%7      �?7!               68g%:!               68a%7      �?7!�               6!%               6      �?      4@      �                      �?      �?      �?      �?              �?       @      �                      �?      �?      �?      �?              �?       @j    ��          6j    ��          6Ttj    ��          6l               6!+               68b%78V%7j               6Rsj    ��          6j4               68b%7!               68b%78]%:8a%778g%:8a%77j    ��          6j    ��          6j    ��          6Uq               6j    ��          6j4               68\%7!               6!8               68]%7       @j    ��          6p               68\%78d%7j    ��          6j4               68O%7!�               6!%               6      �?      *@      �                                                                                              �?j4               68P%7!%               6      0@      1@j    ��          6j    ��          6mn               6!&               68\%78d%7j4               68[%7    Soj4               68[%7   , Ttj    ��          6mn               6!)               68d%7!8               68]%7j4               68f%7!               68f%7      �?l               6!*               68g%:!               6!               6!8               68g%78f%7      �?7       @j4               68P%7!%               6      >@      D@Rsj    ��          6j4               68Z%7!               68Z%7   [ !Z               68g%:!               6!               6!8               68g%78f%7      �?7   , !Z               68O%7   , !Z               68P%7   ] 8[%7j4               68L%7!               68L%78g%:!               6!               6!8               68g%78f%7      �?7Soj    ��          6j4               68Z%7!               68Z%7   [ !Z               68]%:8d%77   , !Z               68O%7   , !Z               68P%7   ] 8[%7j4               68L%7!               68L%78]%:8d%77Ttj    ��          6j    ��          6j4               68U%7!               68U%78P%7j    ��          6j4               68M%7!               68M%78O%7j    ��          6Uq               6j    ��          6j    ��                         6j    ��                        6j               68Z%7j    ��          6j    ��          6j    ��          6	           TencentCapTchaInit                           .   _   r   �          r           �   j    ��                                    6j    ��                                       6j    ��          6j~s��          6j    ��          6	        
   TxHk��ʼ��       }   <�%=�%>�%?�%       &   E           curl       �   dfp_utf8       �   captcha_frame_utf8       �   js_mode_aes        I�%    
     �   d  �          +   H   [   �   �   �       (  N  a  t  �  �    -  @  q  �  �  �    8  a  t  �  �  �  �    K  �  �     z  �  �  M  �  �  	   [   �         <      �   �  �  �  �   F  t  �     i  �      Y     �  �  �   �  j               6@�j    ��          6j              6      D@j    ��          6l               6!&               68A�%7    j4               68A�%7!A               6Rsj    ��          6j4               68=�%7!              6E�j    ��          6j    ��          6j#              6   dfp.js 8=�%7j    ��          6j    ��          6j�              8<�%7   GET 4   https://captcha.gtimg.com/public/2/tokenidiframe.js j�              8<�%7j4               68>�%7!�              8<�%7j    ��          6j    ��          6j#              6   tcaptcha-frame.js 8>�%7j    ��          6j    ��          6j�              8<�%7   GET /   https://captcha.gtimg.com/open/2/d41060624d.js j�              8<�%7j4               68?�%7!�              8<�%7j#              6
   js_aes.js 8?�%7j    ��          6j#              6   md5.js C�j    ��          6j    ��          6j4               68B�7!              6D�j    ��          6j    ��      5                                                        6j    ��      <                                                               6j    ��      P                                                                                   6j    ��                         6j    ��      G                                                                          6j    ��      K                                                                              6j    ��                         6j    ��      ?                                                                  6j    ��      &                                         6j    ��      (                                           6j    ��          6	     �   TxHk       �   �s%�s%�s%�s%�s%       6   Q   l           �����ֲ�����_1          �����ֲ�����_2       �   �����ֲ�����_3       �   �����ֲ�����_4          �����ֲ�����_5     �   �s%:�%�%�%*�%           3   X        �   aid       �   SID       �  ip ���� !    �  �������� 0=http��1=socket      �  UserAndPwd û�п���� �       *   ]   �   �   �   "  a  �  �    l  �  �  �  
  )  S  �  �  �  �  #  >  �  �    D  _    j  �  	  �	  �	  $   *   �   �  =  >  �    ^     M  |  y  �       N   ]   t   {   �   )  S  �  W  �  b  �  �  �  5  q  �  �    K  j  �  �  �	  a  �  �    l  �  
  !       Z  �    �	  j�              8�s%7     @�@     @�@l               6!'               68�%7    j�              8�s%78�%78*�%7!�               6!&               68�%7            j    ��          6Rsj    ��          6j#              6   dfp.js !              6�sj#              6   vm.0f33a0cb.js !              6��j�              8�s%7   GET 4   https://captcha.gtimg.com/public/2/tokenidiframe.js j�              8�s%7j#              6   tcaptcha-frame.js !�              8�s%7j�              8�s%7   GET /   https://captcha.gtimg.com/open/2/d41060624d.js j�              8�s%7j#              6
   js_aes.js !�              8�s%7j#              6   md5.js �sj#              6	   start.js �sj�              8�s%78�s%7j�              8�s%7   HttpGet �sj�              8�s%7   GetXForImage �sj    ��      C                                                                      6j$               6j�              8�s%7   GET !               64   https://ssl.captcha.qq.com/cap_union_prehandle?aid= 8�s%7(  &curenv=inner&protocol=https&clientype=2&disturblevel=&apptype=2&noheader=&color=&showtype=embed&fb=1&theme=&lang=2052&ua=TW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXaW42NDsgeDY0OyBydjo3NS4wKSBHZWNrby8yMDEwMDEwMSBGaXJlZm94Lzc1LjA=&enableDarkMode=0&grayscale=1&cap_cd=&uid=&wxLang=&subsid=1&callback=    _aq_ !Z               6!%               6     j�@    ~�.A   &sess= l               6!'               6!�              8�s%7        j               6    Rsl               6!&               6!             8�s%7!���          6!�              8�s%7   (    )   j               6    Rsj4               68:�%7!             8�s%7   sid l               6!&               68:�%7    j               6    Rsj4               68�s%7!               6   {aid:' 8�s%7   '    ,sid:' 8:�%7	   ',sleep: !Z               6!%               6      $@      Y@   } j�              8�s%7!               6   window.customCaptch =  8�s%7                  j�              8�s%7   RSVM.import('start.js')         �?        j4               68�s%7!�              8�s%7   window.validate ��              �?j    ��      _                                                                                                  6j    ��                     6j               68�s%7	           TencentCapTchaGetQqHkRsHttpGet       i   �s%؆%Ն%       6           �����ֲ�����_1          �����ֲ�����_2          �����ֲ�����_3        �s%        �   ��������_1  4          k   �     p  �  �  *  >  ^  r  �        �    ]  p  )      H          1   H   k   �   �   �   �   *  A  �  �  �  �    >  r      �  j3             8�s%78�s%7k                6!             8Ն%7!4             8�s%7        j�              8؆%7!             8Ն%7   headers j�              8؆%7!             8Ն%7   type !             8Ն%7   url k                6!&               6!�              8؆%7!             8Ն%7   data         k                6!&               6!             8Ն%7   rettype    text j5             8�s%7!�              8؆%7Pj5             8�s%7!�              8؆%7Qrj    ��          6Pj5             8�s%7    Qrj    ��          6Pj5             8�s%7    Qrj    ��          6	        #   TencentCapTchaGetQqHkRsGetXForImage       #   �s%            �����ֲ�����_1        �s%        �   ��������_1            k          6                H       ~   j3             8�s%78�s%7j5             8�s%7!��          6!7             8�s%7        j    ��          6  	      �   �ı�_ȡ�м�       �   #�%$�%%�%&�%       6   Q       �   �����ֲ�����_1      �   �����ֲ�����_2       �   �����ֲ�����_3       �   �����ֲ�����_4     �   �%�% �%!�%"�%       .   E   \        �   ��������_1       �   ��������_2       �   ��������_3      �  ��������_4       �  ��������_5  $       I   �   �     a  �    1     �   `  �  0      `      +   [   t   �   �   �   �   �   �   #  <  U  s  �  �  �  �  �    U  \  u  |      �  j4               68%�%7!`               68�%7   #����   ��j4               68&�%7!`               68 �%7   #����   ��j4               68#�%7!R               68�%78%�%78!�%78"�%7l               6!'               68#�%7      �j4               68#�%7!               68#�%7!L               68%�%7Rsj4               68$�%7!R               68�%78&�%78#�%78"�%7l               6!.               6!&               68#�%7      �!&               68$�%7      �j               6    Rsj               6!O               68�%78#�%7!               68$�%78#�%7	           Debug               ,   G�%H�%       
     �   p  
     �   t         4              $   +       G   j              6!               68G�%78H�%7j    ��          6                                                        s��CJs �׽��»��<s s s s s             ,                                                                                       s��}Ds ��¥������s s s s s                                                               s�+��s �ɳ����գ��s s s s s         ��>�                                                  �   @�A�%B�C�D�E��s%DgdD jvM� c� d� �
                    $   Debug d js_captcha_utf8 MD5 cap dfp �����ֲ�����_1                 ����skW�js 	�൴��ƻ��;s 	s 	s 	s 	s         ���u^                                                 2	��  �              	  �  �            �         	��  �         ss s                                 	                                                       