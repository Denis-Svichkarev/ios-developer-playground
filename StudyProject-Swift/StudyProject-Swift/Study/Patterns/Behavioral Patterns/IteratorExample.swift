//
//  IteratorExample.swift
//  SampleProject Swift
//
//  Created by Denis Svichkarev on 15/11/24.
//

class BookCollection: Sequence {
    private var books: [String] = []
    
    func addBook(_ book: String) {
        books.append(book)
    }

    func makeIterator() -> IndexingIterator<[String]> {
        return books.makeIterator()
    }
}
