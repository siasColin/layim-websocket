package kingim.service;

import kingim.model.User;
import org.springframework.web.multipart.MultipartFile;

import java.util.Map;

public interface UserService {
	 
	  User getUserById(int userId);

	  User matchUser(String userName,String password);

	/**
	 * 根据中户id修改签名
	 * @param userId
	 * @param sign
	 * @return
	 */
      int updateUserSign(int userId, String sign);

	/**
	 * 上传头像
	 * @param imageName
	 * @param userId
	 * @return
	 */
	Map<String,Object> uploadAvatar(MultipartFile imageName,String realPath, int userId);
}
