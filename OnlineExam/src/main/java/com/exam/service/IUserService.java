package com.exam.service;

import com.exam.model.User;

/**
 * service
 * @author zfh14
 *
 */
public interface IUserService {
	public User getUserById(int userId);
	
	public User getUserByParam(User user);
	
	public boolean insertUser(User user);//注册
	
	public int updateUserById(User user);
}
