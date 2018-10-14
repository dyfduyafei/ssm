/** layui-v2.4.3 MIT License By https://www.layui.com */
;layui.define("jquery", function(t) {
    "use strict";
    var e = layui.$
        , i = {
        fixbar: function(t) {
            var i, a, n = "layui-fixbar", r = "layui-fixbar-top", o = e(document), l = e("body");
            t = e.extend({
                showHeight: 200
            }, t),
                t.bar1 = t.bar1 === !0 ? "&#xe606;" : t.bar1,
                t.bar2 = t.bar2 === !0 ? "&#xe607;" : t.bar2,
                t.bgcolor = t.bgcolor ? "background-color:" + t.bgcolor : "";
            var c = [t.bar1, t.bar2, "&#xe604;"]
                , g = e(['<ul class="' + n + '">', t.bar1 ? '<li class="layui-icon" lay-type="bar1" style="' + t.bgcolor + '">' + c[0] + "</li>" : "", t.bar2 ? '<li class="layui-icon" lay-type="bar2" style="' + t.bgcolor + '">' + c[1] + "</li>" : "", '<li class="layui-icon ' + r + '" lay-type="top" style="' + t.bgcolor + '">' + c[2] + "</li>", "</ul>"].join(""))
                , s = g.find("." + r)
                , u = function() {
                var e = o.scrollTop();
                e >= t.showHeight ? i || (s.show(),
                    i = 1) : i && (s.hide(),
                    i = 0)
            };
            e("." + n)[0] || ("object" == typeof t.css && g.css(t.css),
                l.append(g),
                u(),
                g.find("li").on("click", function() {
                    var i = e(this)
                        , a = i.attr("lay-type");
                    "top" === a && e("html,body").animate({
                        scrollTop: 0
                    }, 200),
                    t.click && t.click.call(this, a)
                }),
                o.on("scroll", function() {
                    clearTimeout(a),
                        a = setTimeout(function() {
                            u()
                        }, 100)
                }))
        },
        countdown: function(t, e, i) {
            var a = this
                , n = "function" == typeof e
                , r = new Date(t).getTime()
                , o = new Date(!e || n ? (new Date).getTime() : e).getTime()
                , l = r - o
                , c = [Math.floor(l / 864e5), Math.floor(l / 36e5) % 24, Math.floor(l / 6e4) % 60, Math.floor(l / 1e3) % 60];
            n && (i = e);
            var g = setTimeout(function() {
                a.countdown(t, o + 1e3, i)
            }, 1e3);
            return i && i(l > 0 ? c : [0, 0, 0, 0], e, g),
            l <= 0 && clearTimeout(g),
                g
        },
        timeAgo: function(t, e) {
            var i = this
                , a = [[], []]
                , n = (new Date).getTime() - new Date(t).getTime();
            return n > 6912e5 ? (n = new Date(t),
                a[0][0] = i.digit(n.getFullYear(), 4),
                a[0][1] = i.digit(n.getMonth() + 1),
                a[0][2] = i.digit(n.getDate()),
            e || (a[1][0] = i.digit(n.getHours()),
                a[1][1] = i.digit(n.getMinutes()),
                a[1][2] = i.digit(n.getSeconds())),
            a[0].join("-") + " " + a[1].join(":")) : n >= 864e5 ? (n / 1e3 / 60 / 60 / 24 | 0) + "天前" : n >= 36e5 ? (n / 1e3 / 60 / 60 | 0) + "小时前" : n >= 12e4 ? (n / 1e3 / 60 | 0) + "分钟前" : n < 0 ? "未来" : "刚刚"
        },
        digit: function(t, e) {
            var i = "";
            t = String(t),
                e = e || 2;
            for (var a = t.length; a < e; a++)
                i += "0";
            return t < Math.pow(10, e) ? i + (0 | t) : t
        },
        toDateString: function(t, e) {
            var i = this
                , a = new Date(t || new Date)
                , n = [i.digit(a.getFullYear(), 4), i.digit(a.getMonth() + 1), i.digit(a.getDate())]
                , r = [i.digit(a.getHours()), i.digit(a.getMinutes()), i.digit(a.getSeconds())];
            return e = e || "yyyy-MM-dd HH:mm:ss",
                e.replace(/yyyy/g, n[0]).replace(/MM/g, n[1]).replace(/dd/g, n[2]).replace(/HH/g, r[0]).replace(/mm/g, r[1]).replace(/ss/g, r[2])
        },
        escape: function(t) {
            return String(t || "").replace(/&(?!#?[a-zA-Z0-9]+;)/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/'/g, "&#39;").replace(/"/g, "&quot;")
        }
    };
    !function(t, e, i) {
        "$:nomunge";
        function a() {
            n = e[l](function() {
                r.each(function() {
                    var e = t(this)
                        , i = e.width()
                        , a = e.height()
                        , n = t.data(this, g);
                    (i !== n.w || a !== n.h) && e.trigger(c, [n.w = i, n.h = a])
                }),
                    a()
            }, o[s])
        }
        var n, r = t([]), o = t.resize = t.extend(t.resize, {}), l = "setTimeout", c = "resize", g = c + "-special-event", s = "delay", u = "throttleWindow";
        o[s] = 250,
            o[u] = !0,
            t.event.special[c] = {
                setup: function() {
                    if (!o[u] && this[l])
                        return !1;
                    var e = t(this);
                    r = r.add(e),
                        t.data(this, g, {
                            w: e.width(),
                            h: e.height()
                        }),
                    1 === r.length && a()
                },
                teardown: function() {
                    if (!o[u] && this[l])
                        return !1;
                    var e = t(this);
                    r = r.not(e),
                        e.removeData(g),
                    r.length || clearTimeout(n)
                },
                add: function(e) {
                    function a(e, a, r) {
                        var o = t(this)
                            , l = t.data(this, g) || {};
                        l.w = a !== i ? a : o.width(),
                            l.h = r !== i ? r : o.height(),
                            n.apply(this, arguments)
                    }
                    if (!o[u] && this[l])
                        return !1;
                    var n;
                    return t.isFunction(e) ? (n = e,
                        a) : (n = e.handler,
                        void (e.handler = a))
                }
            }
    }(e, window),
        t("util", i)
});
