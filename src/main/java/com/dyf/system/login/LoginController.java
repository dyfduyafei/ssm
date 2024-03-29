package com.dyf.system.login;

import com.dyf.common.contant.Contants;
import com.dyf.common.controller.BaseController;
import com.dyf.common.msg.MsgInfo;
import com.dyf.common.utils.PropertyUtil;
import com.dyf.common.utils.SystemUtils;
import com.dyf.modules.menu.entity.Menu;
import com.dyf.modules.menu.service.MenuService;
import com.dyf.modules.user.entity.User;
import com.dyf.modules.user.service.UserService;
import com.dyf.system.aspect.annotation.Log;
import com.dyf.system.aspect.enums.BusinessType;
import lombok.extern.slf4j.Slf4j;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * @description: 登录操作
 * @auther: duyafei
 * @date: 2018/10/24 23:15
 */
@Slf4j
@Controller
public class LoginController extends BaseController {

    @Autowired
    private UserService userService;

    @Autowired
    private MenuService menuService;

    /**
     * 登录页面
     */
    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        return "system/login";
    }

    /**
     * 登录认证：用户密码，验证码
     *
     * @param request
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping("/shiroLogin")
    @Log(moduleName = "登录验证", businessType = BusinessType.LOGNIN)
    public MsgInfo shiroLogin(HttpServletRequest request, User user) {
        //获取登录的数据
        String username = WebUtils.getCleanParam(request, "username");
        String password = WebUtils.getCleanParam(request, "password");
        String rememberMe = WebUtils.getCleanParam(request, "rememberMe");
        String verifyCode = WebUtils.getCleanParam(request, "verifyCode");
        //校验验证码
        if (!checkVerifyCode(request, verifyCode)) {
            return MsgInfo.error("验证码不正确!");
        }
        //shiro 正常验证
        Subject currentUser = SecurityUtils.getSubject();

        if (!currentUser.isAuthenticated()) {
            UsernamePasswordToken token = new UsernamePasswordToken(username, password, rememberMe);
            try {
                currentUser.login(token);
                //验证成功将用户信息设置到session(两种)
                User currentUserDetail = userService.getByUserName(username);
                SecurityUtils.getSubject().getSession().setAttribute(Contants.CURRENT_USER, currentUserDetail);
            } catch (IncorrectCredentialsException e) {
                log.error(e.getMessage(), e);
                return MsgInfo.error("用户或密码不正确!");
            } catch (AuthenticationException e) {
                log.error(e.getMessage(), e);
                return MsgInfo.error(e.getMessage());
            }
        }
        return MsgInfo.success();
    }

    /**
     * 校验验证码
     *
     * @param request
     * @param verifyCode
     * @return
     */
    private boolean checkVerifyCode(HttpServletRequest request, String verifyCode) {

        //是否进行图像验证码校验
        if("false".equals(PropertyUtil.getProperty("login.verifyCode"))){
            return true;
        }
        //sesiion中的验证码
        String verifyCodeInSesion = request.getSession().getAttribute(Contants.IMG_CODE_SESSIO_KEY) + "";
        return verifyCode != null && verifyCode.equalsIgnoreCase(verifyCodeInSesion);
    }

    /**
     * 注销,这里切入日志不好使。。。
     */
    @RequestMapping("/logout")
    @Log(moduleName = "用户注销", businessType = BusinessType.LOGOUT)
    public String logout(HttpServletRequest request) {
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:/login";
    }

    /**
     * 没有权限
     */
    @RequestMapping("/unauthorized")
    public String unauthorized() {
        return "error/unauthorized";
    }

    /**
     * index,首页
     */
    @RequestMapping("/index")
    public String index(Model model) {
        //获取用户菜单
        List<Menu> menuList = menuService.getMenuListByUser(SystemUtils.getCurrentUser());
        model.addAttribute("menuList", menuList);
        return "system/index";
//        return "system/index_layui";
    }

    /**
     * index,首页
     */
    @RequestMapping("/console")
    public String console(Model model) {
        return "home/console";
    }


    /**
     * index_v1
     */
    @RequestMapping("/index_v1")
    public String index_v1(HttpServletRequest request) {
        return "home/index_v1";
    }
}
