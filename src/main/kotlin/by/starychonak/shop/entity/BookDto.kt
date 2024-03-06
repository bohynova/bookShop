package by.starychonak.shop.entity

class BookDto (
    val id: Long,
    val title: String,
    val genre: String,
    val author: String,
    val price: Double,
    val sale: Int? = 0,
    val isBestseller: Boolean? = false,
    val isNew: Boolean? = false,
    val imagePath: String?,
    val availableQuantity: Long?
)