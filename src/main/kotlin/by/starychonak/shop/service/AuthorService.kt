package by.starychonak.shop.service

import by.starychonak.shop.entity.Author

interface AuthorService {
    fun findAll(): List<Author>
}