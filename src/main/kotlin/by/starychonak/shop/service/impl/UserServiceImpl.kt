package by.starychonak.shop.service.impl

import by.starychonak.shop.dao.UserDao
import by.starychonak.shop.service.UserService
import org.springframework.stereotype.Service

@Service
class UserServiceImpl(
    val userDao: UserDao
) : UserService {
    override fun findByUsername(username: String) = userDao.findByUserName(username) ?: throw Exception("Пользователя с таким $username не существует")
}