package by.starychonak.shop.service.impl

import by.starychonak.shop.dao.AuthorDao
import by.starychonak.shop.entity.Author
import by.starychonak.shop.service.AuthorService
import org.springframework.stereotype.Service

@Service
class AuthorServiceImpl(
    val authorDao: AuthorDao
) : AuthorService {
    override fun findAll(): List<Author>  = authorDao.findAll()

    override fun findIdsByName(name: String) = authorDao.findIdsByName(name)
    override fun create(author: Author) {
        authorDao.create(author);
    }
}