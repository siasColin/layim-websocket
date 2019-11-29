package kingim.dao;

import kingim.model.Group;
import tk.mybatis.mapper.common.Mapper;

import java.util.List;

public interface GroupMapper extends Mapper<Group> {
    // 获取群组列表
    List<Group> getByUserId(int userId);
}