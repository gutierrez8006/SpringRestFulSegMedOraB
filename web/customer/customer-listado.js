app.controller('ListCustomerController', ['$scope', 'customers', '$uibModal', '$log', 'remoteResourceCustomer', '$window', function ($scope, customers, $uibModal, $log, remoteResourceCustomer, $window) {
        var $ctrlListCust = this;
        // Inicializa seleccion de selreg
        $ctrlListCust.selectedRow = {"seltr": 0, "selreg": customers[0].idCustomer};
        
        $ctrlListCust.filtro = {
            name: ' '
        };
        $ctrlListCust.customers = customers;

        $ctrlListCust.alertMe = function () {
            if (!$ctrlListCust.selectedRow.selreg) {
                $window.alert('Debe seleccionar un registro');
            }
            setTimeout(function () {
                $window.alert($ctrlListCust.selectedRow.selreg);
            });
        };
        
        $ctrlListCust.editar = function (idCustomer) {
            var modalInstance = $uibModal.open({
                animation: true,
                ariaLabelledBy: 'modal-title',
                templateUrl: 'customer/customer-editar.html',
                controller: 'EditCustomerController',
                controllerAs: '$ctrlEditCust',
                size: 'sm',
                resolve: {
                    customer: function () {
                        return remoteResourceCustomer.get(idCustomer);
                    }
                }
            });
            modalInstance.result.then(function (respuesta) {
                if (respuesta.yn === 'y' && (respuesta.nombre === 'customers')) {
                    $ctrlListCust.customers = respuesta.customers;
                } else {
                    $ctrlListCust.bussinessMessages = respuesta.bussinessMessages;
                }
            }, function (cancel) {

            });
        };

        $ctrlListCust.borrar = function (idCustomer) {
            var modalInstance = $uibModal.open({
                animation: true,
                ariaLabelledBy: 'modal-title',
                templateUrl: 'customer/customer-eliminar.html',
                controller: 'DelCustomerController',
                controllerAs: '$ctrlDelCust',
                size: 'sm',
                resolve: {
                    idCustomer: function () {
                        return idCustomer;
                    }}
            });

            modalInstance.result.then(function (respuesta) {
                if (respuesta.yn === 'y' && (respuesta.nombre === 'customers')) {
                    $ctrlListCust.customers = respuesta.customers;
                } else {
                    $ctrlListCust.bussinessMessages = respuesta.bussinessMessages;
                }
                $log.info('Si elimino');
            }, function (cancel) {

            });


        };


        $scope.closeAlert = function (index) {
            $ctrlListCust.bussinessMessages.splice(index, 1);
        };
    }]);

