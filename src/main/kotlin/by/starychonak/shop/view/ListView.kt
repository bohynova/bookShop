package by.starychonak.shop.view

import by.starychonak.shop.entity.BookDto
import by.starychonak.shop.service.BookService
import com.vaadin.flow.component.button.Button
import com.vaadin.flow.component.grid.Grid
import com.vaadin.flow.component.orderedlayout.HorizontalLayout
import com.vaadin.flow.component.orderedlayout.VerticalLayout
import com.vaadin.flow.component.textfield.TextField

import com.vaadin.flow.data.value.ValueChangeMode
import com.vaadin.flow.router.Route
import org.springframework.stereotype.Component

@Route("")
@Component
class ListView(
    val bookService: BookService
): VerticalLayout() {
    var grid = Grid(BookDto::class.java)
    var filterText= TextField()

    init {
        addClassName("list-view")
        setSizeFull()
        configureGrid()
        add(getToolbar(), grid)

        updateList(filterText.value);
    }

    private fun configureGrid() {
        grid.addClassNames("contact-grid")
        grid.setSizeFull()
        grid.removeAllColumns()
        grid.addColumn { it.id }.setHeader("id")
            .setSortable(true)
        grid.addColumn { it.title }.setHeader("Название")
            .setSortable(true)
        grid.addColumn { if(it.isNew == true) "Да" else "Нет"  }.setHeader("Новинка")
            .setSortable(true)
        grid.addColumn { it.author }.setHeader("Автор")
            .setSortable(true)
        grid.addColumn { it.genre }.setHeader("Жанр")
            .setSortable(true)
        grid.addColumn { if (it.availableQuantity != null) it.availableQuantity else "-"}
            .setHeader("Кол-во на складе")
            .setSortable(true)
        grid.getColumns().forEach { col -> col.setAutoWidth(true) }
    }

    private fun getToolbar(): HorizontalLayout {
        filterText.setPlaceholder("введите название...")
        filterText.setClearButtonVisible(true)
        filterText.setValueChangeMode(ValueChangeMode.ON_CHANGE)
        val addContactButton = Button("поиск")
        addContactButton.addClickListener { updateList(filterText.value) }

        val download = Button("скачать")
        download.addClickListener { bookService.fileDownload(filterText.value) }
        val toolbar = HorizontalLayout(filterText, addContactButton, download)
        toolbar.addClassName("toolbar")
        return toolbar
    }

    private fun updateList(title: String) {
        grid.setItems(bookService.findAll(title = title))
    }
}