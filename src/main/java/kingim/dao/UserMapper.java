package kingim.dao;

import kingim.model.User;
import kingim.vo.SNSUser;
import tk.mybatis.mapper.common.Mapper;

public interface UserMapper extends Mapper<User> {

    SNSUser findSNSUserByUserID(int userID);

    int updateUserSign(User user);

    void uploadAvatar(User user);
}