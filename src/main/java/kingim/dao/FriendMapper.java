package kingim.dao;

import kingim.model.Friend;
import org.apache.ibatis.annotations.Param;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;
import java.util.Map;

public interface FriendMapper extends Mapper<Friend> {

    int addFriend(Map<String, Object> params);

    List<Map<String,Object>> getFriend(@Param("userId")int userId, @Param("friendId")int friendId);

    List<Map<String,Object>> getMineGroup(@Param("uId")int uId, @Param("groupId")int groupId);

    List<Map<String,Object>> friendTypeCount(int userId);

    List<Map<String,Object>> getFriendByTypeId(@Param("typeId")int typeId,@Param("userId")int userId);
}