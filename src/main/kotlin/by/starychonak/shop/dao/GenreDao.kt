package by.starychonak.shop.dao

import by.starychonak.shop.entity.Genre

interface GenreDao {
    fun findAll() : List<Genre>
    fun findById(id: Long) : Genre?
    fun findByName(name: String): List<Genre>
    fun findIdsByName(name: String) : List<Long>
    fun create(genre: Genre)
}