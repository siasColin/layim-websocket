package kingim.dao;

import kingim.model.Group;
import kingim.model.GroupUser;
import kingim.vo.SNSUser;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface GroupUserMapper extends Mapper<GroupUser> {

    List<String> getSimpleMemberByGroupId(int groupId);

    List<SNSUser> getMemberByGroupId(int groupId);
}