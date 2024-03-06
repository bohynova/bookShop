package by.starychonak.shop.controller

import by.starychonak.shop.dao.UserDao
import by.starychonak.shop.entity.User
import org.springframework.http.MediaType
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestBody
import org.springframework.web.bind.annotation.RequestMapping
import org.springframework.web.bind.annotation.RestController

@RestController
@RequestMapping(value = ["/api/user"], produces = [MediaType.APPLICATION_JSON_VALUE])
class UserController(
    val userDao: UserDao
) {

    @PostMapping
    fun registerNewUserAccount(@RequestBody user: User) {
        return userDao.create(user)
    }

    @PostMapping("reg")
    fun registerNewUserAccount(@RequestBody request: Map<String, Long>) {
        println(request)
    }
}