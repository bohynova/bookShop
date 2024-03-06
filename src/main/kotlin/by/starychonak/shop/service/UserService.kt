package by.starychonak.shop.service

import by.starychonak.shop.entity.User

interface UserService {
    fun findByUsername(username: String): User
}