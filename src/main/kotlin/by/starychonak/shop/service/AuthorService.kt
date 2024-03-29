package by.starychonak.shop.service

import by.starychonak.shop.entity.Author

interface AuthorService {
    fun findAll(): List<Author>
    fun findIdsByName(name: String): List<Long>

    fun create(author: Author)
}