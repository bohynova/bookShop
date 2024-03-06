package by.starychonak.shop.service

import by.starychonak.shop.entity.Genre

interface GenreService {

    fun findAll(): List<Genre>
    fun findById(id: Long): Genre?
    fun findByName(name: String): List<Genre>
    fun findIdsByName(name: String): List<Long>
    fun create(genre: Genre)
}