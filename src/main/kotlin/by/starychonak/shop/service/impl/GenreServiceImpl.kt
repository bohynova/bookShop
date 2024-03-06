package by.starychonak.shop.service.impl

import by.starychonak.shop.dao.GenreDao
import by.starychonak.shop.entity.Genre
import by.starychonak.shop.service.GenreService
import org.springframework.stereotype.Service

@Service
class GenreServiceImpl(
    val genreDao: GenreDao
) : GenreService {
    override fun findAll(): List<Genre> {
        return genreDao.findAll()
    }

    override fun findById(id: Long): Genre? {
        return genreDao.findById(id)
    }

    override fun findByName(name: String): List<Genre> {
        return genreDao.findByName(name)
    }

    override fun findIdsByName(name: String): List<Long> {
        return genreDao.findIdsByName(name)
    }

    override fun create(genre: Genre) {
        genreDao.create(genre)
    }
}