package by.starychonak.shop.entity

data class Book (
    val id: Long,
    val title: String,
    val genreId: Long,
    val authorId: Long,
    val price: Double,
    val sale: Int? = 0,
    val isBestseller: Boolean? = false,
    val isNew: Boolean? = false,
    val imagePath: String?
)