package kingim.controller;

import com.alibaba.fastjson.JSON;
import kingim.model.User;
import kingim.service.GroupUserService;
import kingim.service.UserService;
import kingim.utils.RedisUtils;
import kingim.vo.SNSMData;
import kingim.vo.SNSMember;
import kingim.vo.SNSUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by sxf on 2019-11-22.
 */
@Controller
@RequestMapping("/group")
public class GroupController {
    @Autowired
    UserService userService;
    @Autowired
    private GroupUserService groupUserService;

    @RequestMapping(value = "getMemberByGroupId", produces = "text/plain; charset=utf-8")
    public @ResponseBody String getMemberByGroupId(int id) {
        SNSMember snsMember = new SNSMember();
        SNSMData snsmData = new SNSMData();
        List<SNSUser> snsUserList = groupUserService.getMemberByGroupId(id);
        if(snsUserList != null && snsUserList.size() > 0){
            snsmData.setList(snsUserList);
        }
        snsMember.setData(snsmData);
        return JSON.toJSONString(snsMember);
    }
}
