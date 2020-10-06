MODULE ListModule
 TYPE ListElem
  REAL                    :: value;
  character(len = 15)     :: palabra;
  TYPE(ListElem), POINTER :: next;
 END TYPE ListElem
END MODULE


SUBROUTINE PrintList(head)
 USE ListModule
 IMPLICIT NONE

 type( ListElem ), pointer :: head
 type( ListElem ), pointer :: ptr

 ptr => head

 print *, "La lista es: "
 DO WHILE ( associated(ptr) )
   print *, ptr%value
   print *, ptr%palabra
   ptr => ptr%next
   print *, "===================="
 END DO
 print *
END SUBROUTINE

!==========================================
SUBROUTINE FindList(head, buscar_ele)
 USE ListModule

 type( ListElem ), pointer :: head
 type( ListElem ), pointer :: ptr
 INTEGER :: encontrado
 ptr => head
 encontrado = 0
 !print *, "The list is: "
 DO WHILE ( associated(ptr) )
   IF (ptr%value == buscar_ele) THEN

     print *, "Se encontro el elemento"
     print *, ptr%value
     print *, ptr%palabra
     encontrado = 1
   END IF
   ptr => ptr%next
 END DO
 IF (encontrado == 0) THEN
     print *, "no se encontro el elemento :c"
 END IF
 print *
END SUBROUTINE

! =======================================

FUNCTION InsertList(head, elem)
 USE ListModule
 IMPLICIT NONE

 type( ListElem ), pointer :: head, elem
 type( ListElem ), pointer :: InsertList

 elem%next => head
 InsertList => elem
END FUNCTION

! =======================================

FUNCTION DeleteList(head)
 USE ListModule
 IMPLICIT NONE

 type( ListElem ), pointer :: head
 type( ListElem ), pointer :: DeleteList

 type( ListElem ), pointer :: h


 IF ( ASSOCIATED(head) ) THEN
    h => head
    head => head%next
    deallocate(h)
 END IF

 DeleteList => head
END FUNCTION



! =======================================

PROGRAM LinkedList
 USE ListModule

 INTERFACE
   SUBROUTINE PrintList(head)
    USE ListModule
    type( ListElem ), pointer :: head
   END SUBROUTINE

   SUBROUTINE FindList(head, buscar_ele)
    USE ListModule
    type( ListElem ), pointer :: head
    REAL :: buscar_ele
   END SUBROUTINE

   FUNCTION InsertList(head, elem)
    USE ListModule
    type( ListElem ), pointer :: head, elem
    type( ListElem ), pointer :: InsertList
   END FUNCTION

   FUNCTION DeleteList(head)
    USE ListModule
    type( ListElem ), pointer :: head
    type( ListElem ), pointer :: DeleteList
   END FUNCTION
 END INTERFACE

 type( ListElem ), pointer :: head
 type( ListElem ), pointer :: newElem
 integer, parameter :: N = 3
 character (len = 15) :: nombre
 INTEGER :: Class
 REAL :: Codigo
 REAL :: buscar_ele

nullify( head )                 ! Inicializar la lista

! ---------------------------------------------
! Menu principal
! ---------------------------------------------
 DO
 print *, "Ingresa Swich"
 print *, "Opcion 1 para ingresar datos"
 print *, "Opcion 2 para imprimir datos"
 print *, "Opcion 3 para buscar datos"
 print *, "Opcion 4 para Salir"

 read *,class
 SELECT CASE (Class)
    CASE (1)
       allocate( newElem )
       print *, "Ingresa Codigo: "
       read *,Codigo
       newElem%value=Codigo
       print *, "Ingresa Nombre: "
       read *,nombre
       newElem%palabra=nombre
       head => InsertList(head, newElem)
    CASE (2)
       CALL PrintList(head)
    CASE (3)
       print *, "Ingresa el codigo del elemento que desees buscar"
       read *, buscar_ele
       CALL FindList(head, buscar_ele)
    CASE (4)
       EXIT
    CASE DEFAULT
       WRITE(*,*)  "Ingresaste una opcion erronea"
 END SELECT

 END DO

end program LinkedList
